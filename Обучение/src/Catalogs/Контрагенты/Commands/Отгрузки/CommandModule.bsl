
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Отбор = Новый Структура;
	Отбор.Вставить("Контрагент", ПараметрКоманды);
	Отбор.Вставить("Проведен", Истина);
	
	ПараметрыФормы = Новый Структура("Отбор", Отбор);
	ПараметрыФормы.Вставить("КлючНазначенияИспользования", "ОтгрузкиКонтрагента");
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	
	ОткрытьФорму("Отчет.НастройкиКомпоновкиДанных.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры
