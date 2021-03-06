&НаКлиенте
Перем ВопросПриЗакрытии;

&НаКлиенте
Процедура ПодобраннаяНоменклатураПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокНоменклатурыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.СписокНоменклатуры.ТекущиеДанные;
	Если Не ТекущиеДанные.ЭтоГруппа Тогда
		СтандартнаяОбработка = Ложь;
		ДобавитьСтроку(ТекущиеДанные);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСтроку(ТекущиеДанные)

	НовСтр = Объект.ПодобраннаяНоменклатура.Добавить();
	НовСтр.Номенклатура = ТекущиеДанные.Ссылка;
	НовСтр.Количество = 1;
	НовСтр.Цена = ТекущиеДанные.Цена;
	НовСтр.ВидНоменклатуры = ТекущиеДанные.ВидНоменклатуры;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПересчитатьСумму");
	
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(НовСтр, СтруктураДействий);
	
	Элементы.ПодобраннаяНоменклатура.ТекущаяСтрока = НовСтр.ПолучитьИдентификатор();

КонецПроцедуры // ДобавитьСтроку()

&НаКлиенте
Процедура ПодобраннаяНоменклатураКоличествоПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ПодобраннаяНоменклатура.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПересчитатьСумму");
	
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий);
КонецПроцедуры

&НаКлиенте
Процедура ПодобраннаяНоменклатураЦенаПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ПодобраннаяНоменклатура.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПересчитатьСумму");
	
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий);
КонецПроцедуры

&НаКлиенте
Процедура ПодобраннаяНоменклатураСуммаПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ПодобраннаяНоменклатура.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПересчитатьЦенуПоСумме");
	
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Отображать = "Все";
	
	Параметры.Свойство("ТипЦен", ТипЦен);
	СписокНоменклатуры.Параметры.УстановитьЗначениеПараметра("ТипЦен", ТипЦен);
	Заголовок = "Подбор в документ " + Параметры.Документ;
	
КонецПроцедуры

&НаКлиенте
Процедура ПеренестиВДокумент(Команда)
	
	//ОповеститьОВыборе(Объект.ПодобраннаяНоменклатура);
	
	АдресВХранилище = ПоместитьДанныеВоВременноеХранилище();
	СтруктураОповещения = Новый Структура;
	СтруктураОповещения.Вставить("АдресПодобранныхДанныхВХранилище", АдресВХранилище);
	
	ВопросПриЗакрытии = Ложь;
	
	ОповеститьОВыборе(СтруктураОповещения);
	
КонецПроцедуры

&НаСервере
Функция ПоместитьДанныеВоВременноеХранилище()

	ТаблицаЗначений = Объект.ПодобраннаяНоменклатура.Выгрузить();
	ТаблицаЗначений.Свернуть("Номенклатура,ВидНоменклатуры,Цена", "Количество,Сумма");
	
	Возврат ПоместитьВоВременноеХранилище(ТаблицаЗначений, УникальныйИдентификатор);	

КонецФункции // ПоместитьДанныеВоВременноеХранилище()

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если ВопросПриЗакрытии и Объект.ПодобраннаяНоменклатура.Количество()>0 Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект),
					   "Подобранные товары не перенесены в документ.
					   |Перенести?",
					   РежимДиалогаВопрос.ДаНетОтмена);
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	ИначеЕсли РезультатВопроса = КодВозвратаДиалога.Нет Тогда
		ВопросПриЗакрытии = Ложь;
		Закрыть();		
	Иначе
		ПеренестиВДокумент("");	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ВопросПриЗакрытии = Истина;
	ИзменитьОтображениеОстатков();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокНоменклатурыНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	//ТекущиеДанные = Элементы.СписокНоменклатуры.ТекущиеДанные;
	//ПараметрыПеретаскивания.Значение = ТекущиеДанные;
	
КонецПроцедуры

&НаКлиенте
Процедура ПодобраннаяНоменклатураПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПодобраннаяНоменклатураПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	СтандартнаяОбработка = Ложь;
	
	мРезультат = ПолучитьДополнительныеДанныеНаСервере(ПараметрыПеретаскивания.Значение, ТипЦен);
	
	Для каждого Стр Из мРезультат Цикл
	
		ДобавитьСтроку(Стр);
	
	КонецЦикла;
	
	//Если ТипЗнч(ПараметрыПеретаскивания.Значение) = Тип("ДанныеФормыСтруктура")
	//	и ПараметрыПеретаскивания.Значение.Свойство("ЭтоГруппа")
	//	и Не ПараметрыПеретаскивания.Значение.ЭтоГруппа	Тогда
	//	
	//	ДобавитьСтроку(ПараметрыПеретаскивания.Значение);		
	//
	//КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьДополнительныеДанныеНаСервере(мНоменклатура, ТипЦен)

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СправочникНоменклатура.Ссылка,
		|	СправочникНоменклатура.ВидНоменклатуры,
		|	ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Цена, 0) КАК Цена
		|ИЗ
		|	Справочник.Номенклатура КАК СправочникНоменклатура
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(
		|				,
		|				ТипЦен = &ТипЦен
		|					И Номенклатура В (&мНоменклатура)) КАК ЦеныНоменклатурыСрезПоследних
		|		ПО ЦеныНоменклатурыСрезПоследних.Номенклатура = СправочникНоменклатура.Ссылка
		|ГДЕ
		|	СправочникНоменклатура.Ссылка В(&мНоменклатура)
		|	И НЕ СправочникНоменклатура.ЭтоГруппа";
	
	Запрос.УстановитьПараметр("мНоменклатура", мНоменклатура);
	Запрос.УстановитьПараметр("ТипЦен", ТипЦен);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	мРезультат = Новый Массив;
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		НовСтрока = Новый Структура("Ссылка, Цена, ВидНоменклатуры");
		ЗаполнитьЗначенияСвойств(НовСтрока, ВыборкаДетальныеЗаписи);
		мРезультат.Добавить(НовСтрока);
		
	КонецЦикла;

	Возврат мРезультат;
	
КонецФункции // ПолучитьДополнительныеДанныеНаСервере()

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	
	ЭлементыОтбора = СписокНоменклатуры.КомпоновщикНастроек.Настройки.Отбор.Элементы;
	Для каждого ЭлементОтбора Из ЭлементыОтбора Цикл
	
		Если ЭлементОтбора.Представление = "ПоискПоПодстроке" Тогда
			ЭлементОтбора.Использование = СокрЛП(СтрокаПоиска) <> "";
			Если ЭлементОтбора.Использование Тогда
				Для каждого ЭлементПоиска Из ЭлементОтбора.Элементы Цикл
				    ЭлементПоиска.ПравоеЗначение = СтрокаПоиска;					
				КонецЦикла;
				
				Элементы.СписокНоменклатуры.Отображение = ОтображениеТаблицы.Список;
			Иначе
				Элементы.СписокНоменклатуры.Отображение = ОтображениеТаблицы.ИерархическийСписок;
			КонецЕсли;	
			
			Прервать;
		
		КонецЕсли;
	
	КонецЦикла;
	
	ТекущийЭлемент = Элементы.СписокНоменклатуры;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтображатьПриИзменении(Элемент)
	
	ИзменитьОтображениеОстатков();
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьОтображениеОстатков()

	ЭлементыОтбора = СписокНоменклатуры.КомпоновщикНастроек.Настройки.Отбор.Элементы;
	Для каждого ЭлементОтбора Из ЭлементыОтбора Цикл
	
		Если ЭлементОтбора.Представление = "Остатки" Тогда
			ЭлементОтбора.Использование = (Отображать <> "Все");
			Прервать;
		КонецЕсли;
	
	КонецЦикла;

КонецПроцедуры // ИзменитьОтображениеОстатков()

&НаКлиенте
Процедура ОтображатьОстаткиНажатие(Элемент)
	
	Видимость = Не Элементы.ОстаткиНаСкладах.Видимость;
	Если Видимость Тогда
		Элементы.ОтображатьОстатки.Заголовок = "Остатки по складам (скрыть)";
		ТекущиеДанные = Элементы.СписокНоменклатуры.ТекущиеДанные;
		Если ТекущиеДанные = Неопределено Тогда
			ОстаткиНаСкладах.Параметры.УстановитьЗначениеПараметра("Номенклатура", Неопределено);
		Иначе
			ОстаткиНаСкладах.Параметры.УстановитьЗначениеПараметра("Номенклатура", ТекущиеДанные.Ссылка);
		КонецЕсли;
		
		Элементы.СписокНоменклатуры.Высота = 5;
		Элементы.ПодобраннаяНоменклатура.Высота = 4;
	Иначе
		Элементы.ОтображатьОстатки.Заголовок = "Остатки по складам (отобразить)";
		Элементы.СписокНоменклатуры.Высота = 8;
		Элементы.ПодобраннаяНоменклатура.Высота = 6;
	КонецЕсли;
	
	Элементы.ОстаткиНаСкладах.Видимость = Видимость;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокНоменклатурыПриАктивизацииСтроки(Элемент)
	
	Если Элементы.ОстаткиНаСкладах.Видимость Тогда
		ТекущиеДанные = Элементы.СписокНоменклатуры.ТекущиеДанные;
		ОстаткиНаСкладах.Параметры.УстановитьЗначениеПараметра("Номенклатура", ТекущиеДанные.Ссылка);	
	КонецЕсли;
	
КонецПроцедуры











