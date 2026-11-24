
IF OBJECT_ID('dbo.vw_АктивностьВолонтеров', 'V') IS NOT NULL DROP VIEW dbo.vw_АктивностьВолонтеров;
IF OBJECT_ID('dbo.vw_ФинансыПроекта', 'V') IS NOT NULL DROP VIEW dbo.vw_ФинансыПроекта;
IF OBJECT_ID('dbo.vw_ПрогрессСборов', 'V') IS NOT NULL DROP VIEW dbo.vw_ПрогрессСборов;


CREATE TABLE dbo.Роли
(
    КодРоли tinyint PRIMARY KEY,
    Наименование nvarchar(50) NOT NULL UNIQUE,
    Описание nvarchar(200) NULL
);
go

CREATE TABLE dbo.ТипыКонтрагентов
(
    КодТипаКонтрагента tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.Специализация
(
    КодСпециализации smallint IDENTITY(1,1) PRIMARY KEY,
    Название nvarchar(100) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.ВидыПожертвований
(
    КодВидаПожертвования tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.СпособыОплаты
(
    КодСпособаОплаты tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.СтатусыПроектов
(
    КодСтатусаПроекта tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.СтатусыЗаявок
(
    КодСтатусаЗаявки tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.СтатусыЗадач
(
    КодСтатусаЗадачи tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.ТипыВзаимодействий
(
    КодТипаВзаимодействия tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.ТипыДействий
(
    КодТипаДействия tinyint PRIMARY KEY,
    Наименование nvarchar(30) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.Контрагенты
(
    КодКонтрагента int IDENTITY(1,1) PRIMARY KEY,
    ФИО nvarchar(150) NULL,
    НазваниеОрганизации nvarchar(200) NULL,
    Телефон varchar(20) NULL,
    Email varchar(100) NULL,
    Адрес nvarchar(300) NULL,
    ДатаРегистрации datetime2 NOT NULL DEFAULT SYSDATETIME(),
    КодТипаКонтрагента tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.ТипыКонтрагентов(КодТипаКонтрагента),
    -- Проверка: либо ФИО (физлицо), либо НазваниеОрганизации (юрлицо)
    CONSTRAINT CK_Контрагент_Имя CHECK (ФИО IS NOT NULL OR НазваниеОрганизации IS NOT NULL)
);
GO

CREATE TABLE dbo.Пользователи
(
    КодПользователя int IDENTITY(1,1) PRIMARY KEY,
    Логин varchar(50) NOT NULL UNIQUE,
    ХешПароля varchar(100) NOT NULL,
    Email varchar(100) NULL,
    Активен bit NOT NULL DEFAULT 1,
    ДатаСоздания datetime2 NOT NULL DEFAULT SYSDATETIME(),
    КодРоли tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.Роли(КодРоли),
    КодКонтрагента int NULL
        FOREIGN KEY REFERENCES dbo.Контрагенты(КодКонтрагента)
);
GO

CREATE TABLE dbo.Волонтеры
(
    КодВолонтера int IDENTITY(1,1) PRIMARY KEY,
    ЧасовОтработано decimal(7,1) NOT NULL DEFAULT 0,
    ИндексАктивности decimal(5,2) NOT NULL DEFAULT 0,
    КодСпециализации smallint NULL
        FOREIGN KEY REFERENCES dbo.Специализация(КодСпециализации),
    КодКонтрагента int NOT NULL UNIQUE
        FOREIGN KEY REFERENCES dbo.Контрагенты(КодКонтрагента)
);
GO

CREATE TABLE dbo.Заявки
(
    КодЗаявки int IDENTITY(1,1) PRIMARY KEY,
    Описание nvarchar(2000) NOT NULL,
    ЗапрашиваемаяСумма money NULL,
    ДатаСоздания datetime2 NOT NULL DEFAULT SYSDATETIME(),
    ДатаРешения datetime2 NULL,
    Комментарий nvarchar(500) NULL,
    КодПользователяМодератора int NULL
        FOREIGN KEY REFERENCES dbo.Пользователи(КодПользователя),
    КодКонтрагентаЗаявителя int NOT NULL
        FOREIGN KEY REFERENCES dbo.Контрагенты(КодКонтрагента),
    КодСтатусаЗаявки tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.СтатусыЗаявок(КодСтатусаЗаявки)
);
GO

CREATE TABLE dbo.Проекты
(
    КодПроекта int IDENTITY(1,1) PRIMARY KEY,
    Наименование nvarchar(200) NOT NULL,
    Описание nvarchar(2000) NULL,
    ЦелеваяСумма money NOT NULL CHECK (ЦелеваяСумма > 0),
    ДатаНачала date NOT NULL DEFAULT CAST(SYSDATETIME() AS date),
    ДатаОкончания date NULL,
    КодЗаявки int NULL UNIQUE
        FOREIGN KEY REFERENCES dbo.Заявки(КодЗаявки),
    КодПользователяОтветственного int NOT NULL
        FOREIGN KEY REFERENCES dbo.Пользователи(КодПользователя),
    КодСтатусаПроекта tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.СтатусыПроектов(КодСтатусаПроекта)
);
GO

CREATE TABLE dbo.Пожертвования
(
    КодПожертвования int IDENTITY(1,1) PRIMARY KEY,
    Сумма money NOT NULL DEFAULT 0 CHECK (Сумма >= 0),
    ДатаПожертвования datetime2 NOT NULL DEFAULT SYSDATETIME(),
    СсылкаНаПлатеж varchar(500) NULL,
    ИдентификаторТранзакции varchar(36) NULL,
    КодПроекта int NULL
        FOREIGN KEY REFERENCES dbo.Проекты(КодПроекта),
    КодКонтрагента int NULL
        FOREIGN KEY REFERENCES dbo.Контрагенты(КодКонтрагента),
    КодВидаПожертвования tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.ВидыПожертвований(КодВидаПожертвования),
    КодСпособаОплаты tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.СпособыОплаты(КодСпособаОплаты)
);
GO

CREATE TABLE dbo.СоставПожертвований
(
    КодСоставаПожертвования int IDENTITY(1,1) PRIMARY KEY,
    Наименование nvarchar(200) NOT NULL,
    Количество int NOT NULL DEFAULT 1 CHECK (Количество > 0),
    СтоимостьЕдиницы money NOT NULL DEFAULT 0 CHECK (СтоимостьЕдиницы >= 0),
    КодПожертвования int NOT NULL
        FOREIGN KEY REFERENCES dbo.Пожертвования(КодПожертвования) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.Расходы
(
    КодРасхода int IDENTITY(1,1) PRIMARY KEY,
    СтатьяРасходов nvarchar(100) NOT NULL,
    Сумма money NOT NULL CHECK (Сумма > 0),
    ДатаРасхода date NOT NULL DEFAULT CAST(SYSDATETIME() AS date),
    ОписаниеРасхода nvarchar(500) NULL,
    КодПроекта int NULL
        FOREIGN KEY REFERENCES dbo.Проекты(КодПроекта),
    КодПользователяСоздателя int NOT NULL
        FOREIGN KEY REFERENCES dbo.Пользователи(КодПользователя)
);
GO

CREATE TABLE dbo.Задачи
(
    КодЗадачи int IDENTITY(1,1) PRIMARY KEY,
    Наименование nvarchar(200) NOT NULL,
    Описание nvarchar(1000) NULL,
    ДатаСоздания datetime2 NOT NULL DEFAULT SYSDATETIME(),
    КрайнийСрок date NULL,
    Баллы int NOT NULL DEFAULT 10 CHECK (Баллы > 0),
    КодСтатусаЗадачи tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.СтатусыЗадач(КодСтатусаЗадачи),
    КодПроекта int NOT NULL
        FOREIGN KEY REFERENCES dbo.Проекты(КодПроекта)
);
GO

CREATE TABLE dbo.НазначенияЗадач
(
    КодНазначенияЗадачи int IDENTITY(1,1) PRIMARY KEY,
    ДатаНазначения datetime2 NOT NULL DEFAULT SYSDATETIME(),
    ДатаЗавершения datetime2 NULL,
    ЗатраченоЧасов decimal(5,1) NULL,
    КодЗадачи int NOT NULL
        FOREIGN KEY REFERENCES dbo.Задачи(КодЗадачи) ON DELETE CASCADE,
    КодКонтрагента int NOT NULL
        FOREIGN KEY REFERENCES dbo.Контрагенты(КодКонтрагента)
);
GO

CREATE TABLE dbo.Взаимодействия
(
    КодВзаимодействия int IDENTITY(1,1) PRIMARY KEY,
    ДатаВзаимодействия datetime2 NOT NULL DEFAULT SYSDATETIME(),
    Описание nvarchar(1000) NOT NULL,
    КодПользователяИнициатора int NOT NULL
        FOREIGN KEY REFERENCES dbo.Пользователи(КодПользователя),
    КодКонтрагента int NOT NULL
        FOREIGN KEY REFERENCES dbo.Контрагенты(КодКонтрагента),
    КодТипаВзаимодействия tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.ТипыВзаимодействий(КодТипаВзаимодействия)
);
GO

CREATE TABLE dbo.ЖурналДействий
(
    КодЗаписиЖурнала int IDENTITY(1,1) PRIMARY KEY,
    ДатаДействия datetime2 NOT NULL DEFAULT SYSDATETIME(),
    ИмяТаблицы varchar(50) NOT NULL,
    КодЗаписиВТаблице int NOT NULL,
    СтарыеЗначения nvarchar(max) NULL,
    НовыеЗначения nvarchar(max) NULL,
    КодПользователя int NOT NULL
        FOREIGN KEY REFERENCES dbo.Пользователи(КодПользователя),
    КодТипаДействия tinyint NOT NULL
        FOREIGN KEY REFERENCES dbo.ТипыДействий(КодТипаДействия)
);
GO


--Прогресс сборов (деньги + оценочная стоимость вещей)
CREATE VIEW dbo.vw_ПрогрессСборов AS
SELECT
    p.КодПроекта,
    p.Наименование,
    p.ЦелеваяСумма,
    p.ДатаНачала,
    p.ДатаОкончания,
    sp.Наименование AS Статус,
    ISNULL((SELECT SUM(Сумма) FROM dbo.Пожертвования WHERE КодПроекта = p.КодПроекта), 0) AS СобраноДеньгами,
    ISNULL((SELECT SUM(c.СтоимостьЕдиницы * c.Количество)
            FROM dbo.Пожертвования d
            JOIN dbo.СоставПожертвований c ON c.КодПожертвования = d.КодПожертвования
            WHERE d.КодПроекта = p.КодПроекта), 0) AS СобраноВещами,
    ISNULL((SELECT SUM(Сумма) FROM dbo.Пожертвования WHERE КодПроекта = p.КодПроекта), 0)
    + ISNULL((SELECT SUM(c.СтоимостьЕдиницы * c.Количество)
              FROM dbo.Пожертвования d
              JOIN dbo.СоставПожертвований c ON c.КодПожертвования = d.КодПожертвования
              WHERE d.КодПроекта = p.КодПроекта), 0) AS ИтогоСобрано,
    ROUND(
        (ISNULL((SELECT SUM(Сумма) FROM dbo.Пожертвования WHERE КодПроекта = p.КодПроекта), 0)
        + ISNULL((SELECT SUM(c.СтоимостьЕдиницы * c.Количество)
                  FROM dbo.Пожертвования d
                  JOIN dbo.СоставПожертвований c ON c.КодПожертвования = d.КодПожертвования
                  WHERE d.КодПроекта = p.КодПроекта), 0))
        * 100.0 / NULLIF(p.ЦелеваяСумма, 0)
    , 1) AS ПроцентВыполнения
FROM dbo.Проекты p
JOIN dbo.СтатусыПроектов sp ON sp.КодСтатусаПроекта = p.КодСтатусаПроекта;
GO

--Финансы проекта (приход vs расход)
CREATE VIEW dbo.vw_ФинансыПроекта AS
SELECT
    p.КодПроекта,
    p.Наименование,
    ISNULL((SELECT SUM(Сумма) FROM dbo.Пожертвования WHERE КодПроекта = p.КодПроекта), 0) AS Доход,
    ISNULL((SELECT SUM(Сумма) FROM dbo.Расходы WHERE КодПроекта = p.КодПроекта), 0) AS Расход,
    ISNULL((SELECT SUM(Сумма) FROM dbo.Пожертвования WHERE КодПроекта = p.КодПроекта), 0)
    - ISNULL((SELECT SUM(Сумма) FROM dbo.Расходы WHERE КодПроекта = p.КодПроекта), 0) AS Остаток
FROM dbo.Проекты p;
GO

--Активность волонтёров
CREATE VIEW dbo.vw_АктивностьВолонтеров AS
SELECT
    v.КодВолонтера,
    k.ФИО,
    k.НазваниеОрганизации,
    s.Название AS Специализация,
    ISNULL(a.ЗадачЗавершено, 0) AS ЗадачЗавершено,
    ISNULL(a.Часов, 0) AS Часов,
    ISNULL(a.Баллов, 0) AS Баллов,
    ROUND((ISNULL(a.Баллов, 0) * 10.0) + (ISNULL(a.Часов, 0) * 2.0), 2) AS РассчитанныйИндекс
FROM dbo.Волонтеры v
JOIN dbo.Контрагенты k ON k.КодКонтрагента = v.КодКонтрагента
LEFT JOIN dbo.Специализация s ON s.КодСпециализации = v.КодСпециализации
OUTER APPLY (
    SELECT
        COUNT(CASE WHEN n.ДатаЗавершения IS NOT NULL THEN 1 END) AS ЗадачЗавершено,
        SUM(n.ЗатраченоЧасов) AS Часов,
        SUM(CASE WHEN n.ДатаЗавершения IS NOT NULL THEN z.Баллы ELSE 0 END) AS Баллов
    FROM dbo.НазначенияЗадач n
    JOIN dbo.Задачи z ON z.КодЗадачи = n.КодЗадачи
    WHERE n.КодКонтрагента = k.КодКонтрагента
) a;
GO


INSERT INTO dbo.Роли (КодРоли, Наименование, Описание) VALUES
(1, N'Администратор', N'Полный доступ к системе'),
(2, N'Координатор проектов', N'Управление проектами и заявками'),
(3, N'Волонтёр', N'Исполнение задач'),
(4, N'Благотворитель', N'Только просмотр и пожертвования');

INSERT INTO dbo.ТипыКонтрагентов (КодТипаКонтрагента, Наименование) VALUES
(1, N'Физическое лицо'),
(2, N'Юридическое лицо');

INSERT INTO dbo.Специализация (Название) VALUES
(N'Доставка грузов'),
(N'Работа с детьми'),
(N'Строительные работы'),
(N'Медицинская помощь');

INSERT INTO dbo.ВидыПожертвований (КодВидаПожертвования, Наименование) VALUES
(1, N'Деньги'),
(2, N'Имущество'),
(3, N'Смешанное');

INSERT INTO dbo.СпособыОплаты (КодСпособаОплаты, Наименование) VALUES
(1, N'Банковская карта'),
(2, N'СБП (QR-код)'),
(3, N'Наличные'),
(4, N'Банковский перевод');

INSERT INTO dbo.СтатусыПроектов (КодСтатусаПроекта, Наименование) VALUES
(1, N'Сбор'),
(2, N'Завершён'),
(3, N'Отменён'),
(4, N'Заморожен');

INSERT INTO dbo.СтатусыЗаявок (КодСтатусаЗаявки, Наименование) VALUES
(1, N'Новая'),
(2, N'На рассмотрении'),
(3, N'Одобрена'),
(4, N'Отклонена'),
(5, N'Закрыта');

INSERT INTO dbo.СтатусыЗадач (КодСтатусаЗадачи, Наименование) VALUES
(1, N'Открыта'),
(2, N'В работе'),
(3, N'Завершена'),
(4, N'Отменена');

INSERT INTO dbo.ТипыВзаимодействий (КодТипаВзаимодействия, Наименование) VALUES
(1, N'Звонок'),
(2, N'Встреча'),
(3, N'Email'),
(4, N'Прочее');

INSERT INTO dbo.ТипыДействий (КодТипаДействия, Наименование) VALUES
(1, N'INSERT'),
(2, N'UPDATE'),
(3, N'DELETE');

-- Контрагенты
INSERT INTO dbo.Контрагенты (ФИО, НазваниеОрганизации, Телефон, Email, Адрес, КодТипаКонтрагента) VALUES
(N'Иванов Иван Иванович', NULL, '+79001112233', 'ivan@test.ru', N'г. Москва, ул. Ленина 1', 1),
(N'Петрова Анна Сергеевна', NULL, '+79004445566', 'anna@test.ru', N'г. Москва, ул. Мира 5', 1),
(N'Сидоров Пётр Алексеевич', NULL, '+79007778899', 'petr@test.ru', N'г. Москва, ул. Садовая 10', 1),
(NULL, N'ООО "Добрые Дела"', '+74951234567', 'info@dobro.ru', N'г. Москва, пр. Мира 100', 2);

-- Пользователи (хеши — заглушки, в C# будешь генерировать BCrypt)
INSERT INTO dbo.Пользователи (Логин, ХешПароля, Email, Активен, КодРоли, КодКонтрагента) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'admin@charity.ru', 1, 1, 1),
('anna_vol', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'anna@test.ru', 1, 3, 2),
('coord1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'coord@charity.ru', 1, 2, NULL);

-- Волонтёры
INSERT INTO dbo.Волонтеры (ЧасовОтработано, ИндексАктивности, КодСпециализации, КодКонтрагента) VALUES
(15.5, 0, 1, 2); -- Петрова Анна, доставка грузов

-- Заявка
DECLARE @ЗаявкаId int;
INSERT INTO dbo.Заявки (Описание, ЗапрашиваемаяСумма, КодПользователяМодератора, КодКонтрагентаЗаявителя, КодСтатусаЗаявки)
OUTPUT INSERTED.КодЗаявки INTO @ЗаявкаId
VALUES (N'Требуется помощь с ремонтом квартиры после затопления и покупка мебели.', 50000, 3, 3, 3); -- Одобрена

-- Проект на основе заявки
DECLARE @ПроектId int;
INSERT INTO dbo.Проекты (Наименование, Описание, ЦелеваяСумма, ДатаОкончания, КодЗаявки, КодПользователяОтветственного, КодСтатусаПроекта)
OUTPUT INSERTED.КодПроекта INTO @ПроектId
VALUES (N'Помощь семье Сидоровых', N'Сбор средств на ремонт и мебель', 50000, DATEADD(month, 2, GETDATE()), (SELECT * FROM @ЗаявкаId), 3, 1);

-- Пожертвование 1: деньги от физлица через СБП
INSERT INTO dbo.Пожертвования (КодПроекта, КодКонтрагента, КодВидаПожертвования, КодСпособаОплаты, Сумма, ИдентификаторТранзакции)
VALUES (@ПроектId, 1, 1, 2, 15000, 'TEST-TXN-001');

-- Пожертвование 2: смешанное от компании
DECLARE @ПожертвованиеId int;
INSERT INTO dbo.Пожертвования (КодПроекта, КодКонтрагента, КодВидаПожертвования, КодСпособаОплаты, Сумма, ИдентификаторТранзакции)
OUTPUT INSERTED.КодПожертвования INTO @ПожертвованиеId
VALUES (@ПроектId, 4, 3, 1, 20000, 'TEST-TXN-002');

-- Состав смешанного пожертвования (вещи)
INSERT INTO dbo.СоставПожертвований (КодПожертвования, Наименование, Количество, СтоимостьЕдиницы) VALUES
(@ПожертвованиеId, N'Строительные материалы (мешки)', 10, 500),
(@ПожертвованиеId, N'Бытовая техника (б/у, рабочая)', 2, 7500);

-- Расходы по проекту
INSERT INTO dbo.Расходы (КодПроекта, СтатьяРасходов, Сумма, ОписаниеРасхода, КодПользователяСоздателя)
VALUES (@ПроектId, N'Закупка материалов', 12000, N'Оплата счёта из собранных средств', 3);

-- Задачи
DECLARE @Задача1 int, @Задача2 int;
INSERT INTO dbo.Задачи (Наименование, Описание, КрайнийСрок, Баллы, КодСтатусаЗадачи, КодПроекта)
OUTPUT INSERTED.КодЗадачи INTO @Задача1
VALUES (N'Доставка строительных материалов', N'Забрать со склада и отвезти по адресу', DATEADD(day, 5, GETDATE()), 20, 1, @ПроектId);

INSERT INTO dbo.Задачи (Наименование, Описание, КрайнийСрок, Баллы, КодСтатусаЗадачи, КодПроекта)
OUTPUT INSERTED.КодЗадачи INTO @Задача2
VALUES (N'Помощь в уборке', N'Помочь вынести старый мусор из квартиры', DATEADD(day, 7, GETDATE()), 15, 1, @ПроектId);

-- Назначение задачи волонтёру (Анна выполнила первую задачу)
INSERT INTO dbo.НазначенияЗадач (ДатаНазначения, ДатаЗавершения, ЗатраченоЧасов, КодЗадачи, КодКонтрагента)
VALUES (DATEADD(day, -3, GETDATE()), DATEADD(day, -1, GETDATE()), 4.5, @Задача1, 2);

-- Взаимодействие
INSERT INTO dbo.Взаимодействия (ДатаВзаимодействия, Описание, КодПользователяИнициатора, КодКонтрагента, КодТипаВзаимодействия)
VALUES (GETDATE(), N'Уточнили детали ремонта по телефону', 3, 3, 1);

GO

-- ====================================================================
-- 6. ПРОВЕРОЧНЫЕ ЗАПРОСЫ
-- ====================================================================
PRINT '=== Прогресс сборов (должен показать ~110%) ===';
SELECT * FROM dbo.vw_ПрогрессСборов;

PRINT '=== Финансы проекта (Доход 35000, Расход 12000, Остаток 23000) ===';
SELECT * FROM dbo.vw_ФинансыПроекта;

PRINT '=== Активность волонтёров ===';
SELECT * FROM dbo.vw_АктивностьВолонтеров;

PRINT '=== Пожертвования с составом ===';
SELECT
    p.ДатаПожертвования,
    ISNULL(k.ФИО, k.НазваниеОрганизации) AS Жертвователь,
    v.Наименование AS Вид,
    s.Наименование AS Способ,
    p.Сумма AS Деньги,
    c.Наименование AS Товар,
    c.Количество,
    c.СтоимостьЕдиницы
FROM dbo.Пожертвования p
LEFT JOIN dbo.Контрагенты k ON k.КодКонтрагента = p.КодКонтрагента
JOIN dbo.ВидыПожертвований v ON v.КодВидаПожертвования = p.КодВидаПожертвования
JOIN dbo.СпособыОплаты s ON s.КодСпособаОплаты = p.КодСпособаОплаты
LEFT JOIN dbo.СоставПожертвований c ON c.КодПожертвования = p.КодПожертвования;
GO
