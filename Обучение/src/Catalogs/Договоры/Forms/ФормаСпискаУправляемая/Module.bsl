&НаКлиенте
Перем ПодтверждениеУстановкиДоговора;

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Отбор.Свойство("Владелец") Тогда
		ОсновнойДоговор = Параметры.Отбор.Владелец.ОсновнойДоговор;	
		Список.Параметры.УстановитьЗначениеПараметра("ОсновнойДоговор", ОсновнойДоговор);
	Иначе
		Элементы.ФормаИспользоватьОсновным.Видимость = Ложь;
		Список.Параметры.УстановитьЗначениеПараметра("ОсновнойДоговор", Неопределено);	
	КонецЕсли;
	
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	Элементы.ФормаИспользоватьОсновным.Пометка = Элементы.Список.ТекущаяСтрока = ОсновнойДоговор;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОсновным(Команда)
	
	ТекущийДоговор = Элементы.Список.ТекущаяСтрока;
	Если ТекущийДоговор = Неопределено или ТекущийДоговор = ОсновнойДоговор Тогда
		Возврат;
	КонецЕсли;
	
	ОсновнойДоговор = ТекущийДоговор;
	Список.Параметры.УстановитьЗначениеПараметра("ОсновнойДоговор", ОсновнойДоговор);
	Элементы.ФормаИспользоватьОсновным.Пометка = Истина;
	
	Контрагент = Элементы.Список.ТекущиеДанные.Владелец;
	ПодтверждениеУстановкиДоговора = Ложь;
	Оповестить("ОсновнойДоговор", ОсновнойДоговор, Контрагент);
	
	Если Не ПодтверждениеУстановкиДоговора Тогда
	
		УстановитьДоговорНаСервере(Контрагент, ОсновнойДоговор);	
	
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УстановитьДоговорНаСервере(Контрагент, ОсновнойДоговор)

	СправочникОбъект = Контрагент.ПолучитьОбъект();
	СправочникОбъект.ОсновнойДоговор = ОсновнойДоговор;
	СправочникОбъект.Записать();

КонецПроцедуры // УстановитьДоговорНаСервере()


&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "УстановленОсновнойДоговор" и ОсновнойДоговор = Параметр Тогда
		ПодтверждениеУстановкиДоговора = Истина;
	КонецЕсли;
	
КонецПроцедуры
















