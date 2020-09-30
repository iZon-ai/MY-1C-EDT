
&НаКлиенте
Процедура ОтобратьПоОсновномуСкладу(Команда)
	ОтобратьПоОсновномуСкладуНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОтобратьПоОсновномуСкладуНаСервере()
	
	Отбор = Список.КомпоновщикНастроек.Настройки.Отбор;
	
	ОтборВПользовательскихНастройках = Список.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(
																			Отбор.ИдентификаторПользовательскойНастройки);
																			
	РаботаемСНастройками = Истина;																		
	Если ОтборВПользовательскихНастройках <> Неопределено Тогда
		
		РаботаемСНастройками = Ложь;
		Отбор = ОтборВПользовательскихНастройках;		
	
	КонецЕсли;																		
																			
	ОтборПоСкладу = Неопределено;
	ПолеСклад = Новый ПолеКомпоновкиДанных("Склад");
	
	Для каждого ЭлементОтбора Из Отбор.Элементы Цикл
	
		Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
			и ЭлементОтбора.ЛевоеЗначение = ПолеСклад Тогда
			
			ОтборПоСкладу = ЭлементОтбора;
			Прервать;
		
		КонецЕсли;	
	
	КонецЦикла;
	
	Если ОтборПоСкладу = Неопределено Тогда
	
		ОтборПоСкладу = Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ОтборПоСкладу.ЛевоеЗначение = ПолеСклад;
		ОтборПоСкладу.Использование = Ложь;
		ОтборПоСкладу.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ;
		ОтборПоСкладу.ИдентификаторПользовательскойНастройки = Новый УникальныйИдентификатор;
		Элементы.Список.СоздатьЭлементыФормыПользовательскихНастроек();
	
	КонецЕсли;
	
	Если РаботаемСНастройками Тогда
	
		ОтборПоСкладу = Список.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ОтборПоСкладу.ИдентификаторПользовательскойНастройки);
	
	КонецЕсли;
	ОтборПоСкладу.Использование = Не ОтборПоСкладу.Использование;
	
	ОтборПоСкладу.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборПоСкладу.ПравоеЗначение = ПолучитьФункциональнуюОпцию("ОсновнойСклад");
	Элементы.ФормаОтобратьПоОсновномуСкладу.Пометка = ОтборПоСкладу.Использование;
	
КонецПроцедуры

&НаКлиенте
Процедура СгруппироватьПоКонтрагентам(Команда)
	
	Группировки = Список.КомпоновщикНастроек.Настройки.Структура;
	
	ПолеКонтрагент = Новый ПолеКомпоновкиДанных("Контрагент");
	ГруппировкаПоКонтрагенту = Неопределено;
	
	Для каждого ГруппировкаСписка Из Группировки Цикл
	
		Если ТипЗнч(ГруппировкаСписка) = Тип("ГруппировкаКомпоновкиДанных") Тогда
			
			Для каждого ПолеГруппировки Из ГруппировкаСписка.ПоляГруппировки.Элементы Цикл
			
				Если ТипЗнч(ПолеГруппировки) = Тип("ПолеГруппировкиКомпоновкиДанных") и
					ПолеГруппировки.Поле = ПолеКонтрагент Тогда
				
					ГруппировкаПоКонтрагенту = ГруппировкаСписка;
					Прервать;
				
				КонецЕсли;
			
			КонецЦикла;				
		
		КонецЕсли;	
	
	КонецЦикла;
	
	Если ГруппировкаПоКонтрагенту = Неопределено Тогда
		
		Группировки.Очистить();
		ГруппировкаПоКонтрагенту = Группировки.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
		ПолеГруппировки = ГруппировкаПоКонтрагенту.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
		ПолеГруппировки.Поле = ПолеКонтрагент;
		
		ГруппировкаПоСкладу = ГруппировкаПоКонтрагенту.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
		ПолеГруппировки = ГруппировкаПоСкладу.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
		ПолеГруппировки.Поле = Новый ПолеКомпоновкиДанных("Склад");
		
		Элементы.ФормаСгруппироватьПоКонтрагентам.Пометка = Истина;
		
	Иначе
		
		Группировки.Очистить();
		Элементы.ФормаСгруппироватьПоКонтрагентам.Пометка = Ложь;
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВывестиНапечать(Команда)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ВывестиНапечатьНаСервере(ТабличныйДокумент);
	ТабличныйДокумент.ОтображатьСетку = Ложь;
	ТабличныйДокумент.ОтображатьЗаголовки = Ложь;
	ТабличныйДокумент.ТолькоПросмотр = Истина;
	ТабличныйДокумент.Показать("Список документов ""Реализация товаров и услуг""");
	
КонецПроцедуры

&НаСервере
Процедура ВывестиНапечатьНаСервере(ТабличныйДокумент)
	
	СхемаКомпоновкиДанных = Элементы.Список.ПолучитьИсполняемуюСхемуКомпоновкиДанных();
	НастройкиКомпоновкиДанных = Элементы.Список.ПолучитьИсполняемыеНастройкиКомпоновкиДанных();
	
	НастройкиКомпоновкиДанных.ПараметрыВывода.УстановитьЗначениеПараметра("МакетОформления", "Зеленый");
	НастройкиКомпоновкиДанных.ПараметрыВывода.УстановитьЗначениеПараметра("Заголовок",
																	   "Список документов ""Реализация товаров и услуг""");
																	   
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ТабличныйДокумент);
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьИтоговуюСумму(Команда)
	РассчитатьИтоговуюСуммуНаСервере();
КонецПроцедуры

&НаСервере
Процедура РассчитатьИтоговуюСуммуНаСервере()
	
	СхемаКомпоновкиДанных = Элементы.Список.ПолучитьИсполняемуюСхемуКомпоновкиДанных();
	НастройкиКомпоновкиДанных = Элементы.Список.ПолучитьИсполняемыеНастройкиКомпоновкиДанных();
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных
												  ,,,Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
	
	ТаблицаЗначений = Новый ТаблицаЗначений;
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ПроцессорВывода.УстановитьОбъект(ТаблицаЗначений);
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	ИтоговаяСумма = ТаблицаЗначений.Итог("СуммаДокумента");
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ОтборПоОсновномуСкладу") Тогда
		
		Элементы.ФормаОтобратьПоОсновномуСкладу.Видимость = Ложь;
		Заголовок = "Отгрузки с основного склада";
		АвтоЗаголовок = Ложь;
		
		ОтобратьПоОсновномуСкладуНаСервере();	
		
		//Список.КлючТекущихПользовательскихНастроек = Новый УникальныйИдентификатор;
	
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьРеализацияТовары(Команда)
	ОткрытьФормуНовогоДокументаПоВидуОперации(ПредопределенноеЗначение("Перечисление.ВидыОперацийРеализацияТоваров.Товары"));
КонецПроцедуры

&НаКлиенте
Процедура СоздатьРеализацияУслуги(Команда)
	ОткрытьФормуНовогоДокументаПоВидуОперации(ПредопределенноеЗначение("Перечисление.ВидыОперацийРеализацияТоваров.Услуги"));	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьРеализацияТоварыИУслуги(Команда)
	ОткрытьФормуНовогоДокументаПоВидуОперации(ПредопределенноеЗначение("Перечисление.ВидыОперацийРеализацияТоваров.ТоварыИУслуги"));	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуНовогоДокументаПоВидуОперации(ВидОперации)

	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("ВидОперации", ВидОперации);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	
	ОткрытьФорму("Документ.РеализацияТоваровУслуг.ФормаОбъекта", ПараметрыФормы, ЭтаФорма);

КонецПроцедуры // ОткрытьФормуНовогоДокументаПоВидуОперации()

&НаКлиенте
Процедура ИзменитьВидОперации(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Ключ", ТекущиеДанные.Ссылка);
	ПараметрыФормы.Вставить("ВидОперации", ТекущиеДанные.ВидОперации);
	
	ОткрытьФорму("Документ.РеализацияТоваровУслуг.Форма.ФормаВыбораВидаОперации", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры











