
&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если ПараметрыЗаписи.Модифицированность Тогда
		
		ОбновитьИнтерфейс();				
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	ПараметрыЗаписи.Вставить("Модифицированность", Модифицированность);
	
КонецПроцедуры
