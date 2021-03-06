Перем МожноЗавершитьРаботуСистемы Экспорт;

Процедура ПередНачаломРаботыСистемы(Отказ)
	
	ПараметрыФОИнтерфейса = Новый Структура;
	ПараметрыФОИнтерфейса.Вставить("Пользователь", ОбщегоНазначенияСервер.ПолучитьТекущегоПользователя());
	
	УстановитьПараметрыФункциональныхОпцийИнтерфейса(ПараметрыФОИнтерфейса);
	
КонецПроцедуры

Процедура ПередЗавершениемРаботыСистемы(Отказ)
	
	Если МожноЗавершитьРаботуСистемы Тогда
		
		МожноЗавершитьРаботуСистемы = Ложь;		
		Возврат;		
	
	КонецЕсли;
	
	Отказ = Истина;
	ПодключитьОбработчикОжидания("ВопросПередЗавершением", 0.1, Истина);
	
КонецПроцедуры

Процедура ВопросПередЗавершением() Экспорт

	Оповещение = Новый ОписаниеОповещения("ЗавершениеРаботыСистемы", ОбщегоНазначенияКлиент);
	ПоказатьВопрос(Оповещение, "Завершить работу системы?", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры


МожноЗавершитьРаботуСистемы = Ложь;