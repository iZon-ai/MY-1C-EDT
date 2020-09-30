
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("РежимВыбораРеквизитовИСведений", РежимВыбораРеквизитовИСведений) Тогда
	
		Если РежимВыбораРеквизитовИСведений = "ВыборОбщего"  Тогда
			Заголовок = "Выбор общего";		
		ИначеЕсли РежимВыбораРеквизитовИСведений = "ВыборПоОбразцу" Тогда
			Заголовок = "Выбор образца";
			Элементы.ФормаСоздать.Видимость = Ложь;		
		КонецЕсли;	
		
		ЭлементыОтбора = Список.КомпоновщикНастроек.Настройки.Отбор.Элементы;
		Для каждого ЭлементОтбора Из ЭлементыОтбора Цикл
			Если ЭлементОтбора.Представление = РежимВыбораРеквизитовИСведений Тогда
				ЭлементОтбора.Использование = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если ТипЗнч(Значение) = Тип("ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения") Тогда
		СтруктураВыбора = Новый Структура;
		СтруктураВыбора.Вставить("РежимВыбораРеквизитовИСведений", РежимВыбораРеквизитовИСведений);
		СтруктураВыбора.Вставить("Значение", Значение);
		
		ОповеститьОВыборе(СтруктураВыбора);	
	КонецЕсли;
	
КонецПроцедуры














