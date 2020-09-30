
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	МВТ = Новый МенеджерВременныхТаблиц;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МВТ;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	РеализацияТоваровУслугТовары.Номенклатура КАК Номенклатура,
		|	СУММА(РеализацияТоваровУслугТовары.Количество) КАК Количество,
		|	РеализацияТоваровУслугТовары.Ссылка.Склад,
		|	РеализацияТоваровУслугТовары.Ссылка.Дата КАК Период,
		|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
		|	МАКСИМУМ(РеализацияТоваровУслугТовары.НомерСтроки) КАК НомерСтроки
		|ПОМЕСТИТЬ ВТ_Товары
		|ИЗ
		|	Документ.РеализацияТоваровУслуг.Товары КАК РеализацияТоваровУслугТовары
		|ГДЕ
		|	РеализацияТоваровУслугТовары.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	РеализацияТоваровУслугТовары.Ссылка.Склад,
		|	РеализацияТоваровУслугТовары.Ссылка.Дата,
		|	РеализацияТоваровУслугТовары.Номенклатура
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_Товары.Номенклатура,
		|	ВТ_Товары.Количество,
		|	ВТ_Товары.Склад,
		|	ВТ_Товары.Период,
		|	ВТ_Товары.ВидДвижения
		|ИЗ
		|	ВТ_Товары КАК ВТ_Товары";
		
	Запрос.УстановитьПараметр("Ссылка",Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	Движения.ТоварыНаСкладах.Загрузить(РезультатЗапроса.Выгрузить());
	Движения.ТоварыНаСкладах.БлокироватьДляИзменения = Истина;
	Движения.ТоварыНаСкладах.Записывать = Истина;
	Движения.Записать();
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МВТ;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВТ_Товары.Номенклатура,
		|	ВТ_Товары.Склад,
		|	ВТ_Товары.НомерСтроки,
		|	-ТоварыНаСкладахОстатки.КоличествоОстаток КАК Недостача
		|ИЗ
		|	ВТ_Товары КАК ВТ_Товары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыНаСкладах.Остатки(&ГраницаВключая, ) КАК ТоварыНаСкладахОстатки
		|		ПО ВТ_Товары.Номенклатура = ТоварыНаСкладахОстатки.Номенклатура
		|ГДЕ
		|	ТоварыНаСкладахОстатки.КоличествоОстаток < 0";
	
	Запрос.УстановитьПараметр("ГраницаВключая", Новый Граница(МоментВремени(),ВидГраницы.Включая));
	РезультатЗапроса = Запрос.Выполнить();
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Отказ = Истина;
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не хватает товара "+ВыборкаДетальныеЗаписи.Номенклатура+". Недостача - "+ВыборкаДетальныеЗаписи.Недостача+".";
		Сообщение.Поле = "Товары["+(ВыборкаДетальныеЗаписи.НомерСтроки-1)+"].Количество";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
	КонецЦикла;
	
	Если Не Отказ Тогда
		
		Движение = Движения.Взаиморасчеты.ДобавитьПриход();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Сумма = СуммаДокумента;
		
		Движения.Взаиморасчеты.Записывать = Истина;	
	
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ДополнительныеСвойства.Свойство("СтандартноеЗаполнение") Тогда
		
		ДополнительныеСвойства.Удалить("СтандартноеЗаполнение");
		Возврат;
	
	КонецЕсли;
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.СчетНаОплатуПокупателю") Тогда
		// Заполнение шапки
		Договор = ДанныеЗаполнения.Договор;
		Контрагент = ДанныеЗаполнения.Контрагент;
		Менеджер = ДанныеЗаполнения.Менеджер;
		Организация = ДанныеЗаполнения.Организация;
		Склад = ДанныеЗаполнения.Склад;
		СуммаДокумента = ДанныеЗаполнения.СуммаДокумента;
		Для Каждого ТекСтрокаТовары Из ДанныеЗаполнения.Товары Цикл
			НоваяСтрока = Товары.Добавить();
			НоваяСтрока.Количество = ТекСтрокаТовары.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаТовары.Номенклатура;
			НоваяСтрока.Сумма = ТекСтрокаТовары.Сумма;
			НоваяСтрока.Цена = ТекСтрокаТовары.Цена;
		КонецЦикла;
		Для Каждого ТекСтрокаУслуги Из ДанныеЗаполнения.Услуги Цикл
			НоваяСтрока = Услуги.Добавить();
			НоваяСтрока.Количество = ТекСтрокаУслуги.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаУслуги.Номенклатура;
			НоваяСтрока.Сумма = ТекСтрокаУслуги.Сумма;
			НоваяСтрока.Цена = ТекСтрокаУслуги.Цена;
		КонецЦикла;
	КонецЕсли;
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		ДополнительныеСвойства.Вставить("СтандартноеЗаполнение");
		Заполнить(ДанныеЗаполнения);
		СтандартнаяОбработка = Ложь;
				
	КонецЕсли;

	Если Не ЗначениеЗаполнено(Склад) Тогда
		
		Склад = ХранилищеОбщихНастроек.Загрузить("ОсновнойСклад");		
	
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	МассивНепроверяемыхРеквизитов = Новый Массив();
	
	ПараметрыФО = Новый Структура;
	ПараметрыФО.Вставить("Контрагент", Контрагент);
	
	ВестиУчетПоДоговорам = ПолучитьФункциональнуюОпцию("ВестиУчетПоДоговорам", ПараметрыФО);
	
	Если Не ВестиУчетПоДоговорам Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Договор");		
	
	КонецЕсли;
	
	ПараметрыФО = Новый Структура;
	ПараметрыФО.Вставить("Организация", Организация);
	ПараметрыФО.Вставить("Период", Дата);
	
	ОказаниеУслуг = ПолучитьФункциональнуюОпцию("ОказаниеУслуг", ПараметрыФО);
	
	Если Не ОказаниеУслуг Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Услуги.Номенклатура");
		МассивНепроверяемыхРеквизитов.Добавить("Услуги.Количество");
		
		ПроверяемыеРеквизиты.Добавить("Товары");
		
	ИначеЕсли Товары.Количество()=0 и Услуги.Количество()=0 Тогда
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не введено ни одной строки";
		Сообщение.Поле = "Товары";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		
		Отказ = Истина; 
	
	КонецЕсли;
	
	Для каждого Элемент Из МассивНепроверяемыхРеквизитов Цикл
	
		Индекс = ПроверяемыеРеквизиты.Найти(Элемент);
		
		Если Индекс<>Неопределено Тогда
			
			ПроверяемыеРеквизиты.Удалить(Индекс);			
		
		КонецЕсли;
	
	КонецЦикла;	
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

	СуммаДокумента = Товары.Итог("Сумма")+Услуги.Итог("Сумма");	
	
КонецПроцедуры










