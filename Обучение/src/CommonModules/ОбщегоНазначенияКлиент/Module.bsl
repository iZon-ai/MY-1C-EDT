Процедура ЗавершениеРаботыСистемы(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		
		#Если ВебКлиент Тогда
			ЗавершитьРаботуСистемы(Ложь);
		#Иначе	
			МожноЗавершитьРаботуСистемы = Истина;
			ЗавершитьРаботуСистемы();
		#КонецЕсли
	
	КонецЕсли;	

КонецПроцедуры
