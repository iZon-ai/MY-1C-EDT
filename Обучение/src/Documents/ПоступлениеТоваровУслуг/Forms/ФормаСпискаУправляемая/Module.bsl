
&НаКлиенте
Процедура НавигационнаяСсылкаДокумента(Команда)
	
	ТекущийДокумент = Элементы.Список.ТекущаяСтрока;
	Если ЗначениеЗаполнено(ТекущийДокумент) Тогда
	
		НавигационнаяСсылкаДокумента = ПолучитьНавигационнуюСсылкуИнформационнойБазы()+"/#"+ПолучитьНавигационнуюСсылку(ТекущийДокумент);
		Сообщить(НавигационнаяСсылкаДокумента);
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НавигационнаяСсылкаСписка(Команда)
	
	НавигационнаяСсылкаСписка = Окно.ПолучитьНавигационнуюСсылку();
	Сообщить(НавигационнаяСсылкаСписка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПереходПоСсылкеНаСписок(Команда)
	
	ПерейтиПоНавигационнойСсылке("e1cib/list/Документ.РеализацияТоваровУслуг");	
	
КонецПроцедуры

&НаКлиенте
Процедура ВызовКомандыГлобальногоИнтерфейса(Команда)
	
	ПерейтиПоНавигационнойСсылке("e1cib/command/Документ.РеализацияТоваровУслуг.Команда.ОтгрузкиСОсновногоСклада");
	
КонецПроцедуры

&НаКлиенте
Процедура ПереходПоСсылкеНаОбщуюФорму(Команда)
	
	ПерейтиПоНавигационнойСсылке("e1cib/app/ОбщаяФорма.ПерсональныеНастройки");
	
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьРазделПродажи(Команда)
	
	ПерейтиПоНавигационнойСсылке("e1cib/navigationpoint/Продажи");	
	
КонецПроцедуры



