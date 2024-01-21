DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    id                   SERIAL PRIMARY KEY,
    name                 VARCHAR(255),
    lastname             VARCHAR(255),
    email                VARCHAR(255) UNIQUE,
    password_hash        VARCHAR(255),
    role                 VARCHAR(50),
    refresh_token        VARCHAR(255),
    reset_password_token VARCHAR(255),
    created_at           TIMESTAMP DEFAULT NOW(),
    updated_at           TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (name, lastname, email, password_hash, role)
VALUES ('Jan', 'Nowak', 'admin@admin.com', '$2b$10$j1yPpwKj7Qilx6ycaHf2A.U.sNOK6lcnU61KyEGmkFuDx9uugiTXK', 'admin'),
       ('Test', 'Cypress', 'cypress@test.pl', '$2b$10$B/v2BYW1LI7ZOszgLY8ake59cQSfCx9yPZOJMZyT4RECZlBVpjloe', 'user');


DROP TABLE IF EXISTS refresh_tokens;

CREATE TABLE refresh_tokens
(
    id            SERIAL PRIMARY KEY,
    user_id       INT REFERENCES "users" (id),
    refresh_token VARCHAR
);


DROP TABLE IF EXISTS calendar;

CREATE TABLE calendar
(
    id       SERIAL PRIMARY KEY,
    user_id  INT REFERENCES "users" (id),
    title    VARCHAR NOT NULL,
    content  VARCHAR NOT NULL,
    priority INT     NOT NULL,
    date     VARCHAR NOT NULL
);

INSERT INTO calendar (user_id, title, content, priority, date)
VALUES (1, 'testowy temat', 'testowa wiadomość', 1, '12/1/2024'),
       (1, 'testowy temat2', 'testowa wiadomość2', 3, '3/2/2024');


DROP TABLE IF EXISTS navigation;

CREATE TABLE navigation
(
    id        SERIAL PRIMARY KEY,
    name_pl   VARCHAR NOT NULL,
    name_en   VARCHAR NOT NULL,
    route     VARCHAR NOT NULL,
    published BOOLEAN NOT NULL DEFAULT TRUE,
    user_only BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO navigation (name_pl, name_en, route)
VALUES ('Etapy ciąży', 'Stages of pregnancy', '/stages'),
       ('Zdrowie', 'Health', '/health'),
       ('Wyprawka', 'Layette', '/layette');

INSERT INTO navigation (name_pl, name_en, route, user_only)
VALUES ('Kalendarz', 'Calendar', '/calendar', TRUE),
       ('Zdjęcia', 'Images', '/images', TRUE);


DROP TABLE IF EXISTS pregnancy_stages;

CREATE TABLE pregnancy_stages
(
    id              SERIAL PRIMARY KEY,
    week            INT NOT NULL UNIQUE,
    description_pl  VARCHAR,
    description_en  VARCHAR,
    image_header_pl VARCHAR,
    image_header_en VARCHAR,
    length_cm       VARCHAR DEFAULT '',
    weight_kg       VARCHAR DEFAULT ''
);

INSERT INTO pregnancy_stages (week, description_pl, description_en, image_header_pl, image_header_en, length_cm,
                              weight_kg)
VALUES (1,
        'Twój organizm przygotowuje się do ewentualnego zapłodnienia. Masz miesiączkę, co oznacza, że błona macicy złuszcza się, a na jej miejsce pojawia się nowy nabłonek – to pozwoli jej przyjąć zapłodnione jajeczko. W tym czasie wzrasta poziom estrogenów, umożliwiający przebieg owulacji.',
        '',
        'Przygotowanie',
        'Preparation',
        '',
        ''),
       (2,
        'Kończy się krwawienie, a w twoich jajnikach rosną pęcherzyki Graffa. Za kilka dni jeden z nich dojrzeje na tyle, aby uwolnić komórkę jajową do jajowodu (to tzw. jajeczkowanie, czyli owulacja). W szyjce macicy pojawia się gęsty śluz w ciąży, który ułatwi plemnikowi dotarcie do komórki jajowej.',
        '',
        'Proces zapłodnienia',
        'Fertilization process',
        '',
        ''),
       (3,
        'To moment owulacji, a więc rzeczywistego zapłodnienia. Do komórki jajowej przesuwającej się jajowodem do macicy, dociera plemnik. Razem zamienią się w komórkę z 23 parami chromosomów – to zygota. Komórka dzieli się co kilkanaście godzin, aby ostatecznie rozwinął się z niej człowiek.',
        '',
        'Implantacja',
        'Implantation',
        '',
        ''),
       (4,
        'Na początku ciąży zygota przesuwa się w kierunku macicy i zagnieżdża się w niej. Odżywia się substancjami znajdującymi się w endometrium. Cały czas dzieli się, tworząc zarodek oraz część, z której powstanie łożysko, a wokół nich powstaje pęcherzyk ciążowy. Rozpoczyna się organogenza, czyli proces powstawania narządów i układów wewnętrznych.',
        '',
        'Twoje dziecko jest mniej więcej wielkości ziarenka maku',
        'Your baby is about the size of a poppy seed',
        '',
        ''),
       (5,
        'Pęcherzyk ciążowy, oprócz zarodka, mieści w sobie jeszcze pęcherzyk żółtkowy, wydzielający progesteron i jamę owodni. Rozwija się wątroba, nerki, a przede wszystkim mózg oraz rdzeń kręgowy oraz serce. Pojawiają się mięśnie i tkanki, formuje łożysko.',
        '',
        'Twoje dziecko jest mniej więcej wielkości nasionka sezamu',
        'Your baby is about the size of a sesame seed',
        '',
        ''),
       (6,
        'Zamyka się cewa nerwowa – jej niedomknięcie wiązałoby się z ryzykiem wad rozwojowych, jak rozszczep kręgosłupa lub wodogłowie. Serce płodu zaczyna bić i pompować krew do tworzącego się krwioobiegu. Tworzą się zalążki układu pokarmowego i oskrzela.',
        '',
        'Twoje dziecko jest mniej więcej wielkości soczewicy',
        'Your baby is about the size of a lentil',
        '',
        ''),
       (7,
        'W główce płodu powstają gałki oczne, uszy i nozdrza, języka i ust, a także zalążki zębów. Dziecko ma kształt kijanki, ale widoczne są już ręce i nóżki. Serce dzieli się na 2 komory, kształtuje się kościec zbudowany z miękkich chrząstek. Widać zawiązki narządów rodnych.',
        '',
        'Twoje dziecko jest mniej więcej wielkości jagody',
        'Your baby is about the size of a blueberry',
        '',
        ''),
       (8,
        'Embrion ma wyraźnie wyodrębnioną głowę z zarysowaną twarzyczką i tułów. Oczy dziecka mają już siatkówkę, rogówkę, tęczówkę i soczewkę. Powstaje ucho środkowe odpowiedzialne za równowagę. Tworzy się pępowina, doskonalą się narządy: wątroba, nerki, płuca.',
        '',
        'Twoje dziecko jest mniej więcej wielkości fasoli',
        'Your baby is about the size of a kidney bean',
        '1.57',
        '0.02'),
       (9,
        'Na kończynach malca widać już paluszki połączone błoną i opuszki. W pępowinie formują się jelita, które przemieszczają się do jamy brzusznej. W mózgu tworzą się pierwsze połączenia nerwowe.',
        '',
        'Twoje dziecko jest mniej więcej wielkości winogrona',
        'Your baby is about the size of a grape',
        '2.29',
        '0.03'),
       (10,
        'Rośnie mózg, a wraz z nim główka płodu. Formują się stawy, dlatego zgina on już rączki i nóżki. Rozwijają się płuca, powstaje przepona.',
        '',
        'Twoje dziecko jest mniej więcej wielkości kumkwatu',
        'Your baby is about the size of a kumquat',
        '3.1',
        '0.03'),
       (11,
        'Serce dzieli się na kolejne części i dostarcza krew do naczyń krwionośnych i narządów. Pępowina zasila krwią rozwijające się łożysko. Płód zaczyna intensywnie rosnąć, ma już teraz ok. 60 mm. Zaczynają pracować nerki, wydalając mocz do płynu owodniowego.',
        '',
        'Twoje dziecko jest mniej więcej wielkości figi',
        'Your baby is about the size of a fig',
        '4.09',
        '0.05'),
       (12,
        'Kończy się okres organogenezy, na ciele malca pojawia się meszek pełniący rolę termoregulacyjną. Płód pobiera glukozę z płynu owodniowego, zaczyna produkować też własne hormony. Maluszek potrafi ssać kciuk.',
        '',
        'Twoje dziecko jest mniej więcej wielkości limonki',
        'Your baby is about the size of a lime',
        '5.41',
        '0.06'),
       (13,
        'Zaczyna działać łożysko, które dostarcza płodowi tlenu i składników odżywczych. Dziecko jest bardzo ruchliwe, porusza kończynami, paluszkami, marszczy czoło. Oczy i uszy przesuwają się na właściwe sobie miejsca na twarzy.',
        '',
        'Twoje dziecko jest mniej więcej wielkości strąka grochu',
        'Your baby is about the size of a peapod',
        '6.71',
        '0.07'),
       (14,
        'Na skórze dziecka powstają komórki czuciowe. Formują się narządy płciowe dziecka: u dziewczynek pojawia się pochwa, macica i jajniki, w a nich komórki jajowe. Płód wdycha i wydycha płyn owodniowy, trenując odruch oddychania.',
        '',
        'Twoje dziecko jest mniej więcej wielkości cytryny',
        'Your baby is about the size of a lemon',
        '14.71',
        '0.09'),
       (15,
        'U dziecka rozwija się słuch - twardnieją kostki w uchu środkowym. Na buzi maluszka widać brwi, a na głowie – włoski.',
        '',
        'Twoje dziecko jest mniej więcej wielkości jabłka',
        'Your baby is about the size of an apple',
        '16.69',
        '0.12'),
       (16,
        'Organizm malca zatrzymuje wapń, dzięki czemu twardnieje jego kościec. Coraz mocniejsze są mięśnie dziecka, dzięki czemu potrafi ono koordynować ruchy swojego ciała.',
        '',
        'Twoje dziecko jest mniej więcej wielkości awokado',
        'Your baby is about the size of an avocado',
        '18.59',
        '0.15'),
       (17,
        'Narządy płciowe są na tyle duże i widoczne, że podczas badania USG można określić już płeć dziecka. Skóra płodu staje się grubsza, choć nadal jest przezroczysta.',
        '',
        'Twoje dziecko jest mniej więcej wielkości rzepy',
        'Your baby is about the size of a turnip',
        '20.4',
        '0.18'),
       (18,
        'Malec trenuje odruchy ssania i szukania pokarmu. Na jego opuszkach palców tworzą się linie papilarne. Dziecko reaguje na dotyk, odczuwa ciałem i wychwytuje uszami fale dźwiękowe, jego oczy są wrażliwe na światło. Jelita wypełniają się smółką.',
        '',
        'Twoje dziecko jest mniej więcej wielkości papryki',
        'Your baby is about the size of a bell pepper',
        '22.2',
        '0.22'),
       (19,
        'Układ nerwowy rozwija się produkują melinę – to substancja przewodząca impulsy i wpływająca na przyszłą inteligencję dziecka. Dzięki niej włókna nerwowe odtąd będą lepiej przewodziły impulsy. Układ pokarmowy dziecka zaczyna wydzielać soki trawienne.',
        '',
        'Twoje dziecko jest mniej więcej wielkości tradycyjnego pomidora',
        'Your baby is about the size of an heirloom tomato',
        '24',
        '0.27'),
       (20,
        'W mózgu płodu kształtują się komórki zmysłowe (smaku, powonienia, słuchu itd.). Tworzą się też połączenia nerwowe odpowiedzialne za pamięć i myślenie. W buzi dziecka powstają zalążki zębów.',
        '',
        'Twoje dziecko jest mniej więcej wielkości banana',
        'Your baby is about the size of a banana',
        '25.7',
        '0.33'),
       (21,
        'Nerki przejmują od łożyska funkcję produkcji płynu owodniowego. Filtrują też go i wytwarzają mocz, który za pośrednictwem krwiobiegu mamy jest wydalany na zewnątrz przez jej układ.',
        '',
        'Twoje dziecko jest mniej więcej wielkości marchewki',
        'Your baby is about the size of a carrot',
        '27.41',
        '0.4'),
       (22,
        'Rozwijają się gruczołu potowe na skórze, rosną paznokcie. U chłopców jądra zaczynają produkować plemniki.',
        '',
        'Twoje dziecko jest mniej więcej wielkości dyni makaronowej',
        'Your baby is about the size of a spaghetti squash',
        '29.01',
        '0.48'),
       (23,
        'Ciało maluszka nabiera proporcji zbliżonych do proporcji noworodka. Doskonali się słuch dziecka, które potrafi rozpoznać twój głos oraz głos taty – jeśli często go słyszy.',
        '',
        'Twoje dziecko jest mniej więcej wielkości dużego mango',
        'Your baby is about the size of a large mango',
        '30.61',
        '0.57'),
       (24,
        'Organizm rozpoczyna produkcję białych krwinek, odpowiedzialnych za odporność dziecka. Rozwijają się płuca, przygotowując się do wdychania tlenu w przyszłości – tworzą się przewody i pęcherzyki, rusza produkcja surfaktantu – substancji niezbędnej do sprawnego przebiegu procesu oddychania.',
        '',
        'Twoje dziecko jest mniej więcej wielkości kłosa kukurydzy',
        'Your baby is about the size of an ear of corn',
        '32.21',
        '0.67'),
       (25,
        'Powstają zawiązki zębów stałych, a w ustach – rozwijają się nerwy czuciowe potrzebne w przyszłości do sprawnego szukania piersi przez malca. Pępowina staje się gruba, zapewniając sprawny przepływ coraz większej ilości substancji i tlenu.',
        '',
        'Twoje dziecko jest mniej więcej wielkości brukwi',
        'Your baby is about the size of a rutabaga',
        '33.71',
        '0.78'),
       (26,
        'Wzmacnia się kręgosłup płodu i mięśnie. Warstwa tłuszczu w skórze zwiększa się, dzięki czemu malec staje się pulchniejszy.',
        '',
        'Twoje dziecko jest mniej więcej wielkości szalotki',
        'Your baby is about the size of a scallion',
        '35.1',
        '0.91'),
       (27,
        'Dzięki ssaniu kciuka dziecko wzmacnia mięśnie twarzy i jamy ustnej. Na języku formują się kubki smakowe. Malec otwiera i zamyka powieki, reagując na natężenie światła przechodzącego przez powłoki brzuszne mamy.',
        '',
        'Twoje dziecko jest mniej więcej wielkości główki kalafiora',
        'Your baby is about the size of a head of cauliflower',
        '36.6',
        '1.06'),
       (28,
        'Narządy wewnętrzne są na tyle rozwinięte, że organizm może skupić się na wzroście. Dziecko w tym wieku waży już ok. 1 kg. Jądra chłopców zstępują do moszny.',
        '',
        'Twoje dziecko jest mniej więcej wielkości dużego bakłażana',
        'Your baby is about the size of a large eggplant',
        '37.59',
        '1.21'),
       (29,
        'Dziecko jest coraz większe i jest mu coraz ciaśniej w macicy, dlatego mocniej odczuwasz każdy jego ruch. Mózg rozwija się intensywnie wpływając na kształt o wzrost główki. Jest silnie pofałdowany i nieustannie tworzy nowe połączenia nerwowe.',
        '',
        'Twoje dziecko jest mniej więcej wielkości dyni piżmowej',
        'Your baby is about the size of a butternut squash',
        '39.29',
        '1.38'),
       (30,
        'Zanika meszek pokrywający ciało dziecka, ale włosy na główce i rzęsy stają się coraz gęstsze. Szpik kostny produkuje czerwone krwinki. Wiele dzieci w tym wieku zmienia pozycję główką w dół.',
        '',
        'Twoje dziecko jest mniej więcej wielkości dużej kapusty',
        'Your baby is about the size of a large cabbage',
        '40.51',
        '1.56'),
       (31,
        'Malec ma wygląd noworodka, na USG można odczytać rysy jego twarzy. Stale rośnie, wydłużają się jego nogi. Płód ma wyraźny rytm snu i czuwania. Ożywia się, gdy coś zjesz i gdy odpoczywasz, a w ciągu dnia śpi kołysany ruchami twojego ciała.',
        '',
        'Twoje dziecko jest mniej więcej wielkości kokosa',
        'Your baby is about the size of a coconut',
        '41.81',
        '1.75'),
       (32,
        'Malec uczy się obracania główką na boki, otwiera i zamyka oczy, stale ćwiczy płuca pobudzając produkcję surfaktantu.',
        '',
        'Twoje dziecko jest mniej więcej wielkości kłębiana',
        'Your baby is about the size of a jicama',
        '43',
        '1.95'),
       (33,
        'Rośnie główka dziecka, robiąc miejsce dla stale rosnącego mózgu – w ciągu tygodnia może powiększyć się ona nawet o 9 mm. Zwiększa się tez ilość tłuszczu w skórze malca.',
        '',
        'Twoje dziecko jest mniej więcej wielkości ananasa',
        'Your baby is about the size of a pineapple',
        '44.09',
        '2.16'),
       (34,
        'Rozwija się układ immunologiczny dziecka, dzięki czemu malec nabiera odporności. Rosną ostre paznokietki na dłoniach i stópkach.',
        '',
        'Twoje dziecko jest mniej więcej wielkości kantalupy',
        'Your baby is about the size of a cantaloupe',
        '45.31',
        '2.38'),
       (35,
        'Centralny układ nerwowy jest w pełni dojrzały, jeśli dziecko urodziłoby się teraz, podjął by działanie. Sprawnie funkcjonuje układ pokarmowy.',
        '',
        'Twoje dziecko jest mniej więcej wielkości melona spadziowego',
        'Your baby is about the size of a honeydew melon',
        '46.3',
        '2.59'),
       (36, 'Dziecko rośnie, dlatego ma coraz mniej miejsca. Rozpycha się, dając ci mocne kuksańce.',
        '',
        'Twoje dziecko jest mniej więcej wielkości główki sałaty rzymskiej',
        'Your baby is about the size of a head of romaine lettuce',
        '47.29',
        '2.81'),
       (37,
        'Jeśli malec do tej pory nie zmienił pozycji, to ma na to coraz mniejsze szanse – brak miejsca utrudnia fikołki, mimo to istnieje jeszcze taka możliwość. Działa układ odpornościowy dziecka. Masa dziecka w tym wieku to ok. 3 kg.',
        '',
        'Twoje dziecko jest mniej więcej wielkości pęczka boćwiny',
        'Your baby is about the size of a bunch of Swiss chard',
        '48.31',
        '3.03'),
       (38,
        'Ciąża jest już donoszona, co oznacza, że dziecko może bezpiecznie się urodzić i że może stać się to w każdej chwili. Łożysko starzeje się, czyli przestaje pełnić swoje funkcje – to naturalny objaw zbliżającego się porodu. Jelita wypełnia smółka, pierwsze odchody, które będą wydalone po porodzie. Dziecko wpasowuje się główką w kanał rodny, dlatego możesz zauważyć opuszczenie się brzucha.',
        '',
        'Twoje dziecko jest mniej więcej wielkości pora',
        'Your baby is about the size of a leek',
        '49.3',
        '3.23'),
       (39,
        'Płuca są gotowe do podjęcia oddychania, Dzięki obecności w nich surfaktantu, zapobiegającemu sklejanie się pęcherzyków płucnych. Pępowina jest długa, często owija malca, ale nie martw się – w czasie porodu może się to zmienić.',
        '',
        'Twoje dziecko jest mniej więcej wielkości miniarbuza',
        'Your baby is about the size of a mini-watermelon',
        '50.09',
        '3.43'),
       (40,
        'Dziecko ma w pełni rozwinięty szkielet i narządy, gotowe do podjęcia samodzielnej pracy poza macicą. Jest gotowe do narodzin.',
        '',
        'Twoje dziecko jest mniej więcej wielkości małej dyni',
        'Your baby is about the size of a small pumpkin',
        '51',
        '3.62');


DROP TABLE IF EXISTS article;

CREATE TABLE article
(
    id             SERIAL PRIMARY KEY,
    category       VARCHAR,
    title_pl       VARCHAR,
    title_en       VARCHAR,
    description_pl VARCHAR,
    description_en VARCHAR,
    image_name     VARCHAR,
    content_pl     VARCHAR,
    content_en     VARCHAR,
    published      BOOLEAN DEFAULT TRUE,
    published_date VARCHAR
);

INSERT INTO article (category, title_pl, title_en, description_pl, description_en, image_name, content_pl, content_en,
                     published_date)
VALUES ('health', '10 zasad prawidłowej diety w ciąży', 'Title 1',
        'Jakie są zasady prawidłowego odżywiania w czasie ciąży i jakich produktów nie może zabraknąć w codziennym jadłospisie kobiety w ciąży?',
        'Description1',
        'dieta-w-ciazy.webp',
        '<article><h1>Dieta przyszłej mamy, czyli co jeść w ciąży?</h1><div class="d-flex justify-content-center"><svg id="SvgjsSvg1361" width="550" height="550" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"><defs id="SvgjsDefs1362"></defs><g id="SvgjsG1363"><svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 5500 4000" viewBox="0 0 5500 4000" width="550" height="550"><path fill="#a1c992" d="M4693.036,1773.59c-418.396-555.85-963.087-357.208-1452.057-302.768
          c-502.262-102.396-1108.805-834.045-2003.708-256.123c-1115.89,720.634-673.957,2403.863,337.502,2403.863
          c0,0,526.866,0,1130.285,0c91.205,0,184.141,0,277.289,0c394.744,0,764.569,0,986.625,0
          C4788.631,3618.561,5156.681,2389.552,4693.036,1773.59z" class="colora1c992 svgShape"></path><path fill="#7eb769" d="M3622.571,2763.635c-214.792,225.233-354.685,607.219-401.153,745.561
              c-9.288,28.478-14.854,46.918-16.179,50.989c0.274,0.54-0.266,0.814-0.266,0.814s13.001,1.54,36.567,3.827
              c160.874,16.005,812.062,55.084,1120.688-308.793c354.023-417.489,499.199-944.046,555.565-1100.312
              c0,0-14.565,7.401-45.629,17.078c-35.656,11.323-92.943,25.5-174.076,35.502
              C4546.365,2226.338,3887.899,2484.218,3622.571,2763.635z" class="color7eb769 svgShape"></path><path fill="#6ca856" d="M3622.571,2763.635c-214.792,225.233-354.685,607.219-401.153,745.561
              c-9.288,28.478-14.854,46.918-16.179,50.989c235.122-89.884,554.985-9.498,931.851-344.205
              c195.181-173.347,273.523-721.076,490.732-866.749c73.297-49.468,146.583-100.289,217.698-152.717
              c6.465-4.644,16.154-13.636,26.645-23.715c-35.656,11.323-92.943,25.5-174.076,35.502
              C4546.365,2226.338,3887.899,2484.218,3622.571,2763.635z" class="color6ca856 svgShape"></path><path fill="#72a659" d="M4750.472,2355.474c-109.346,125.486-231.761,238.603-352.827,351.706
              c-122.688,112.585-247.015,223.276-375.446,327.227c-127.062,106.653-270.517,189.052-414.512,271.726
              c-127.29,71.468-255.955,138.885-386.269,203.064c-10.613,32.548-16.445,51.803-16.445,51.803s13.001,1.54,36.567,3.827
              c131.63-69.604,261.337-142.987,388.592-219.865c141.803-86.988,285.218-176.153,410.624-287.393
              c126.498-109.093,247.826-223.017,366.975-339.894C4525.518,2600.795,4644.66,2483.905,4750.472,2355.474z" class="color72a659 svgShape"></path><path fill="#6ca856" d="M3617.015 3258.184c-6.743-84.178-6.199-169.978 3.288-254.438 10.017-84.105 28.739-169.243 73.433-242.671-47.504 71.696-69.802 156.97-83.081 241.372-12.8 85.025-16.678 170.934-13.049 257.315.225 5.374 4.768 9.548 10.14 9.322 5.376-.226 9.548-4.766 9.324-10.141-.003-.11-.01-.22-.021-.33L3617.015 3258.184zM3852.858 3096.086c-6.743-84.179-6.199-169.978 3.288-254.438 10.016-84.104 28.739-169.243 73.433-242.67-47.504 71.696-69.802 156.97-83.085 241.371-12.796 85.026-16.674 170.934-13.045 257.315.224 5.375 4.764 9.548 10.14 9.323 5.376-.225 9.548-4.766 9.323-10.14-.007-.111-.01-.22-.021-.329L3852.858 3096.086zM4126.272 2903.785c-6.748-84.18-6.204-169.978 3.288-254.439 10.017-84.104 28.739-169.243 73.433-242.67-47.504 71.696-69.802 156.97-83.085 241.371-12.796 85.026-16.674 170.934-13.044 257.315.224 5.375 4.764 9.548 10.14 9.322 5.376-.225 9.548-4.766 9.324-10.14-.007-.111-.014-.221-.021-.329L4126.272 2903.785z" class="color6ca856 svgShape"></path><path fill="#6aa34f" d="M4406.872,2661.173c8.765-69.227,23.692-138.69,45.613-205.499
              c22.292-66.448,51.738-132.29,100.376-184.284c-51.028,49.717-84,114.954-109.546,181.012
              c-25.273,66.672-43.483,135.547-55.758,206.267c-0.916,5.302,2.633,10.344,7.936,11.265c5.298,0.919,10.345-2.631,11.261-7.934
              c0.023-0.135,0.047-0.27,0.062-0.406L4406.872,2661.173z" class="color6aa34f svgShape"></path><path fill="#6ca856" d="M3670.697 3378.251c62.84 19.998 126.637 34.309 191.655 41.932 64.629 7.136 131.733 7.812 193.794-12.71-62.979 17.35-128.985 13.269-192.455 3.066-63.587-10.657-126.379-28.153-186.262-50.56l-.366-.136c-5.037-1.885-10.655.67-12.538 5.71-1.887 5.039.672 10.654 5.709 12.539C3670.378 3378.146 3670.552 3378.205 3670.697 3378.251zM3919.481 3216.174c62.844 19.998 126.637 34.309 191.659 41.932 64.629 7.136 131.729 7.812 193.794-12.71-62.979 17.35-128.985 13.269-192.455 3.066-63.587-10.656-126.379-28.152-186.266-50.561l-.362-.136c-5.041-1.886-10.655.671-12.538 5.711-1.887 5.039.667 10.653 5.708 12.539C3919.167 3216.069 3919.34 3216.128 3919.481 3216.174zM4183.824 3024.743c65.944.584 131.123-4.546 195.502-16.428 63.858-12.233 128.176-31.368 181.436-69.273-55.064 35.144-119.343 50.703-183 59.662-63.903 8.561-129.062 10.354-192.894 6.594l-.386-.023c-5.374-.317-9.981 3.782-10.3 9.153-.314 5.372 3.78 9.982 9.153 10.298C4183.488 3024.735 4183.671 3024.74 4183.824 3024.743zM4448.339 2772.405c52.462-15.817 102.77-35.903 150.855-61.146 47.574-25.38 93.853-56.327 126.672-99.403-35.352 40.961-82.633 68.474-130.964 90.665-48.604 21.928-99.874 38.816-151.249 50.982l-.371.089c-5.238 1.24-8.478 6.491-7.238 11.728 1.239 5.238 6.491 8.478 11.729 7.238C4447.956 2772.515 4448.163 2772.458 4448.339 2772.405z" class="color6ca856 svgShape"></path><path fill="#7eb769" d="M3399.93,2665.22c-150.465,272.444-188.634,677.446-198.4,823.057
              c-1.742,29.903-2.437,49.153-2.683,53.427c0.403,0.453-0.05,0.855-0.05,0.855s12.965-1.817,36.338-5.597
              c159.656-25.426,799.379-153.204,1005.342-583.595c236.235-493.783,242.756-1039.948,257.537-1205.41
              c0,0-12.205,10.861-39.787,28.119c-31.604,20.016-83.405,48.294-159.328,78.596
              C4156.749,1910.693,3585.492,2327.521,3399.93,2665.22z" class="color7eb769 svgShape"></path><path fill="#6ca856" d="M4386.981,1983.688c-73.846,149.165-163.476,289.69-251.805,429.858
                c-90.03,140.08-182.126,278.745-279.905,411.935c-95.768,135.455-213.557,251.622-331.799,368.191
                c-104.935,101.484-212.229,199.4-321.942,294.604c-1.988,34.177-2.733,54.282-2.733,54.282s12.965-1.817,36.338-5.597
                c109.606-100.785,216.391-204.736,319.917-311.443c115.025-120.184,231.054-242.884,324.055-382.354
                c94.602-137.671,182.976-278.701,268.492-422.031C4231.797,2278.144,4317.302,2134.802,4386.981,1983.688z" class="color6ca856 svgShape"></path><path fill="#6ca856" d="M3520.306 3144.928c-27.931-79.698-49.221-162.815-61.517-246.912-11.701-83.887-15.239-170.988 9.318-253.367-27.717 81.418-27.597 169.559-18.982 254.564 9.241 85.484 27.334 169.556 52.806 252.175 1.585 5.141 7.04 8.023 12.18 6.438 5.141-1.585 8.021-7.038 6.436-12.178-.03-.105-.064-.209-.103-.313L3520.306 3144.928zM3707.181 2928.19c-27.927-79.697-49.217-162.815-61.516-246.912-11.697-83.887-15.239-170.988 9.318-253.367-27.713 81.419-27.598 169.56-18.982 254.564 9.246 85.486 27.334 169.556 52.811 252.176 1.585 5.14 7.035 8.022 12.176 6.437 5.141-1.585 8.021-7.038 6.44-12.177-.034-.106-.068-.21-.103-.314L3707.181 2928.19zM3922.713 2672.69c-27.927-79.697-49.217-162.815-61.517-246.912-11.696-83.886-15.239-170.988 9.318-253.366-27.713 81.419-27.597 169.56-18.982 254.564 9.246 85.485 27.334 169.556 52.811 252.176 1.585 5.141 7.035 8.022 12.176 6.438 5.141-1.585 8.026-7.037 6.44-12.177-.034-.106-.068-.21-.103-.313L3922.713 2672.69zM4132.402 2366.705c-9.121-69.181-12.351-140.156-8.136-210.343 4.661-69.933 16.4-141.098 50.221-203.751-36.708 61.058-52.014 132.535-59.924 202.917-7.489 70.907-7.591 142.148-1.475 213.665.455 5.36 5.174 9.335 10.534 8.877 5.36-.458 9.335-5.176 8.876-10.537-.011-.137-.022-.272-.042-.407L4132.402 2366.705zM3602.746 3247.4c65.865 3.363 131.202.982 196.021-8.178 64.323-9.531 129.386-25.94 184.194-61.567-56.494 32.793-121.375 45.629-185.35 51.899-64.206 5.862-129.384 4.907-192.998-1.538l-.388-.039c-5.351-.542-10.13 3.358-10.674 8.711-.544 5.353 3.359 10.133 8.71 10.675C3602.412 3247.378 3602.598 3247.392 3602.746 3247.4z" class="color6ca856 svgShape"></path><path fill="#6ca856" d="M3602.746 3247.4c65.865 3.363 131.202.982 196.021-8.178 64.323-9.531 129.386-25.94 184.194-61.567-56.494 32.793-121.375 45.629-185.35 51.899-64.206 5.862-129.384 4.907-192.998-1.538l-.388-.039c-5.351-.542-10.13 3.358-10.674 8.711-.544 5.353 3.359 10.133 8.71 10.675C3602.412 3247.378 3602.598 3247.392 3602.746 3247.4zM3802.147 3027.392c65.861 3.363 131.198.982 196.021-8.178 64.319-9.532 129.386-25.94 184.194-61.567-56.499 32.792-121.375 45.629-185.35 51.899-64.206 5.862-129.384 4.907-192.998-1.538l-.388-.04c-5.355-.542-10.135 3.358-10.674 8.711-.543 5.353 3.354 10.132 8.71 10.675C3801.813 3027.37 3802 3027.384 3802.147 3027.392zM4009.125 2775.04c63.927-16.202 125.661-37.736 184.9-65.598 58.652-28.068 115.991-62.928 157.86-113.129-44.319 47.99-102.532 79.381-161.813 104.231-59.628 24.528-122.19 42.83-184.879 55.423l-.377.077c-5.277 1.06-8.694 6.196-7.636 11.47 1.062 5.276 6.198 8.693 11.471 7.633C4008.8 2775.118 4008.983 2775.077 4009.125 2775.04zM4200.79 2463.738c46.715-28.636 90.261-60.853 130.35-97.494 39.554-36.642 76.447-78.338 97.234-128.343-23.778 48.603-62.51 87.234-103.609 120.984-41.432 33.567-86.719 62.935-133.311 87.764l-.338.181c-4.754 2.53-6.551 8.433-4.021 13.183 2.531 4.75 8.434 6.548 13.183 4.017C4200.443 2463.942 4200.633 2463.834 4200.79 2463.738z" class="color6ca856 svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#edefbc" d="M3832.507 1655.278c-13.162 4.644-26.356 9.939-39.651 17.223-49.345 27.874-88.861 74.512-117.929 116.941-.069 1.32-.101 1.98-1.188 2.147-34.387 51.745-52.796 96.449-52.796 96.449s.506.578 1.559 1.071c2.105.986 6.859 2.876 14.261 5.668 0 0 0 0 .542-.084 6.891 2.209 15.377 4.826 26.003 7.779 43.073 11.049 112.779 17.351 180.945-20.615 89.802-50.444 148.354-164.81 165.346-202.753 2.374-4.287 4.199-8.499 6.027-12.709C4015.626 1666.395 3927.793 1624.273 3832.507 1655.278zM3575.402 1403.14c-5.316 12.905-10.168 26.268-13.606 41.033-12.132 55.36-3.727 115.907 8.508 165.862.938.931 1.408 1.396.808 2.317 15.631 60.13 36.669 103.659 36.669 103.659s.768.008 1.837-.447c2.138-.911 6.718-3.194 13.734-6.848 0 0 0 0 .299-.46 6.241-3.662 13.85-8.241 23.136-14.191 36.956-24.73 88.134-72.475 105.296-148.589 22.291-100.559-23.892-220.456-40.838-258.419-1.612-4.628-3.533-8.796-5.452-12.967C3705.796 1274.09 3615.836 1311.456 3575.402 1403.14zM3924.731 1286.672c-8.209 7.283-16.248 15.049-23.772 24.294-27.674 34.924-42.63 80.6-51.224 120.113.341.981.513 1.472-.229 1.916-9.706 47.875-9.864 85.886-9.864 85.886s.54.271 1.452.318c1.825.094 5.848.061 12.066-.099 0 0 0 0 .37-.222 5.673-.434 12.628-1.043 21.242-2.042 34.643-4.719 87.274-20.789 125.664-68.64 50.448-63.351 59.194-163.991 60.323-196.659.458-3.826.539-7.434.623-11.042C4061.383 1240.497 3984.935 1235.853 3924.731 1286.672z" class="coloredefbc svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#edefbc" d="M1664.643 3207.413c2.972 13.637 6.587 27.386 12.162 41.484 21.527 52.426 62.894 97.431 101.382 131.545 1.301.232 1.952.346 1.983 1.445 47.072 40.55 89.142 64.371 89.142 64.371s.636-.43 1.256-1.414c1.24-1.966 3.706-6.449 7.396-13.447 0 0 0 0-.016-.549 3.048-6.563 6.699-14.658 10.949-24.835 16.316-41.366 31.229-109.75 2.028-182.104-38.895-95.374-145.1-167.683-180.638-189.257-3.959-2.888-7.911-5.222-11.862-7.56C1698.427 3027.094 1645.718 3109.013 1664.643 3207.413zM1382.514 3431.197c12.145 6.879 24.801 13.354 39.025 18.599 53.423 18.916 114.546 18.1 165.634 12.166 1.041-.815 1.56-1.224 2.399-.514 61.607-8.039 107.412-23.506 107.412-23.506s.104-.761-.216-1.879c-.638-2.235-2.335-7.062-5.089-14.479 0 0 0 0-.419-.354-2.859-6.648-6.456-14.767-11.206-24.72-19.947-39.743-60.962-96.456-134.354-122.942-97.01-34.613-221.716-3.685-261.491 8.412-4.793 1.025-9.167 2.413-13.544 3.799C1270.665 3285.78 1296.564 3379.685 1382.514 3431.197zM1064.592 3160.663c7.706 5.358 15.78 10.478 24.98 14.871 34.601 15.975 75.58 19.213 110.156 18.404.747-.481 1.12-.723 1.639-.196 41.75-1.568 73.38-9.088 73.38-9.088s.116-.503-.028-1.271c-.289-1.536-1.126-4.874-2.511-10.01 0 0 0 0-.259-.263-1.502-4.628-3.409-10.288-5.973-17.247-10.896-27.847-34.848-68.363-82.351-90.644-62.816-29.184-148.235-16.197-175.618-10.56-3.273.389-6.288 1.048-9.304 1.705C998.703 3056.363 1010.23 3120.847 1064.592 3160.663zM1015.526 2906.906c4.874 6.033 10.094 11.961 16.375 17.574 23.752 20.675 55.51 32.723 83.124 40.078.704-.209 1.056-.314 1.345.224 33.481 8.413 60.31 9.764 60.31 9.764s.209-.373.272-1.015c.126-1.285.234-4.126.324-8.521 0 0 0 0-.144-.269-.121-4.019-.324-8.949-.749-15.062-2.202-24.61-11.83-62.289-44.359-90.951-43.078-37.68-113.84-47.136-136.866-48.998-2.686-.448-5.23-.623-7.775-.8C987.384 2808.931 981.613 2862.748 1015.526 2906.906zM1310.353 3070.104c6.206 9.051 12.913 17.992 21.152 26.606 31.215 31.799 74.678 52.314 112.818 65.751 1.016-.217 1.524-.326 1.873.465 46.298 15.58 83.995 20.459 83.995 20.459s.336-.502.496-1.402c.32-1.799.788-5.795 1.401-11.984 0 0 0 0-.174-.395.274-5.683.534-12.66.613-21.331-.378-34.96-9.784-89.18-52.494-133.218-56.592-57.929-155.366-79.112-187.64-84.291-3.739-.93-7.309-1.458-10.879-1.99C1281.515 2928.774 1267.407 3004.053 1310.353 3070.104z" class="coloredefbc svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#7eb769" d="M1640.637,1219.771c151.601,244.507,62.711,514.615-15.317,562.994
              s-359.49,7.901-511.091-236.607s-57.994-681.232-57.994-681.232S1489.036,975.264,1640.637,1219.771z" class="color7eb769 svgShape"></path><path fill="#6ca856" d="M1139.745 985.707c41.892 59.311 82.004 119.725 121.579 180.472 39.504 60.791 78.309 122.016 116.515 183.612 38.21 61.594 75.794 123.575 112.682 185.989 36.821 62.455 73.093 125.25 107.569 189.158-41.915-59.297-82.033-119.707-121.603-180.457-39.503-60.792-78.309-122.016-116.49-183.627-38.185-61.609-75.771-123.589-112.657-186.004C1210.523 1112.393 1174.244 1049.602 1139.745 985.707zM1212.377 1041.782c19.605-18.629 26.66-48.717 32.717-75.088 1.177 30.31 2.172 61.304-14.337 89.218C1230.756 1055.912 1212.377 1041.782 1212.377 1041.782L1212.377 1041.782zM1302.837 1179.822c10.534-5.029 19.617-16.033 27.508-28.325 24.541-37.36 38.377-80.951 40.364-126.095 2.551 30.185-.28 61.188-8.667 91.016-10.295 30.994-18.992 61.913-47.42 83.37C1314.621 1199.786 1302.837 1179.822 1302.837 1179.822L1302.837 1179.822zM1410.307 1339.934c69.549-39.649 117.167-109.03 124.497-189.921.531 83.961-43.15 160.856-111.653 209.219C1423.153 1359.233 1410.307 1339.934 1410.307 1339.934L1410.307 1339.934zM1529.608 1513.071c56.281-12.847 105.538-63.929 115.118-125.993-.885 31.312-12.17 62.587-31.058 88.781-18.864 26.194-45.557 47.76-77.35 59.402L1529.608 1513.071 1529.608 1513.071zM1165.692 1100.052c-37.493 10.221-75.315-7.102-99.463-34.263 26.766 18.961 62.417 28.116 91.642 12.438C1157.871 1078.228 1165.692 1100.052 1165.692 1100.052L1165.692 1100.052zM1246.694 1238.753c-49.447 32.122-129.741 23.232-179.477-3.336 28.001 10.318 57.835 14.309 86.746 11.824 25.354-2.611 59.144-9.313 77.251-25.744C1231.213 1221.497 1246.694 1238.753 1246.694 1238.753L1246.694 1238.753zM1361.264 1401.921c-72.052 47.06-164.127 56.511-241.174 27.869 79.408 21.29 166.419 2.265 227.617-46.675L1361.264 1401.921 1361.264 1401.921zM1452.546 1586.513c-46.761 55.302-129.136 76.148-194.281 42.453 16.074 6.305 33.234 8.891 50.147 9.148 50.452 1.509 97.793-25.123 126.016-66.067C1434.428 1572.049 1452.546 1586.513 1452.546 1586.513L1452.546 1586.513zM1608.046 1644.998c39.129-3.443 68.523-38.335 82.832-73.921-7.974 41.585-34.761 84.512-78.171 96.63C1612.708 1667.707 1608.046 1644.998 1608.046 1644.998L1608.046 1644.998zM1546.928 1715.982c-29.984 31.791-77.812 34.792-117.764 26.886 37.582-.56 78.685-8.706 100.097-41.898C1529.262 1700.97 1546.928 1715.982 1546.928 1715.982L1546.928 1715.982z" class="color6ca856 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#f6af9a" d="M1640.505,2516.818c-0.028-0.032,394.51-566.219,522.486-700.153
            c56.664-65.599,150.222-92.476,236.165-60.334c110.325,41.261,166.314,164.146,125.053,274.472
            c-8.575,22.929-20.686,43.501-35.466,61.351c-3.483,4.206-7.116,8.258-10.884,12.155
            c-69.491,77.429-368.187,393.885-638.835,637.758c-40.306,45.851-106.197,64.533-166.774,41.878
            c-78.296-29.282-118.03-116.491-88.748-194.786C1594.96,2558.518,1615.311,2533.822,1640.505,2516.818z" class="colorf6af9a svgShape"></path><path fill="#ffffff" d="M2514.065,1788.573c0,0-196.885-125.387-315.028-16.067
              c-118.144,109.32-374.802,450.906-438.214,532.158c-63.412,81.251-190.634,265.299-202.923,310.255
              s-0.63,127.798,79.837,174.785c80.468,46.988,152.315,10.915,223.1-45.122c70.785-56.037,585.091-554.022,651.039-638.035
              S2607.123,1859.478,2514.065,1788.573z" class="colorfff svgShape"></path><path fill="#e5e6eb" d="M2572.41 1945.127l-235.114-75.399c0 0-5.676 66.528-66.444 185.169-57.402 112.071-225.8 299.721-159.931 456.084 167.698-161.827 362.11-354.948 400.956-404.435C2544.397 2065.117 2567.991 2004.469 2572.41 1945.127zM1749.924 2318.816l134.059 294.401c72.052-188.307 32.433-421.97 18.064-491.312-63.197 80.874-116.684 151.313-141.225 182.757C1757.372 2309.084 1753.723 2313.825 1749.924 2318.816z" class="colore5e6eb svgShape"></path><path fill="#f6af9a" d="M3457.544,3496.309H2299.161c24.171-93.418,62.621-209.699,122.535-327.475
            c23.611-46.569,16.332-107.603,7.56-163.224c0,0,108.162-166.304,493.404-158.837c339.234,6.626,368.351,43.116,368.351,43.116
            C3311.168,2994.412,3457.544,3323.754,3457.544,3496.309z" class="colorf6af9a svgShape"></path><path fill="#f6af9a" d="M2377.969,2568.717c0,0-98.033-45.355-115.368-140.164
              c-17.335-94.807,79.812-325.403,93.184-472.755c13.372-147.351-109.09-151.505-169.137-166.497
              c0,0,120.893-151.009,485.147-256.68c0,0,145.738-33.257,307.014-29.011c38.992,1.026,81.716-0.463,120.249,6.674
              c161.513,29.914,279.351,81.567,310.769,132.32c31.418,50.752-0.567,243.309-25.974,398.354
              c-28.868,176.169-62.357,371.774-67.733,531.455c-2.597,77.131-13.835,316.467-9.641,496.753c0,0,0.432-94.347-382.562-10.09
              c-382.994,84.257-509.103-45.669-509.103-45.669C2401.671,2865.106,2377.969,2568.717,2377.969,2568.717z" class="colorf6af9a svgShape"></path><path fill="#f6af9a" d="M2605.732,1559.68c0,0,50.059-396.244,50.059-396.244
                c8.161-78.634,67.006-145.857,148.684-161.047c99.428-18.491,195.02,47.122,213.51,146.549
                c2.516,13.53,3.463,26.988,2.991,40.192c0.005,0,5.196,429.477,5.196,429.477c0.103,2.997-0.079,16.589-0.079,16.589
                c-0.976,100.922-72.908,183.168-175.871,202.316c-116.974,21.754-225.965-49.675-247.719-166.649
                C2595.726,1634.416,2600.589,1597.598,2605.732,1559.68z" class="colorf6af9a svgShape"></path><path fill="#ea9a88" d="M2655.791,1163.437c8.161-78.635,67.006-145.858,148.684-161.047
                c99.428-18.491,195.02,47.122,213.51,146.55c2.516,13.531,3.463,26.988,2.991,40.192c0.005,0-89.677,145.713-89.677,145.713
                c-65.973,107.41-176.933,163.318-316.438,152.577L2655.791,1163.437L2655.791,1163.437z" class="colorea9a88 svgShape"></path><path fill="#ffffff" d="M3505.751,3618.561H2095.88c-74.348-110.329-118.962-275.029-92.013-458.915
                s168.966-416.393,356.802-521.56c-18.953-27.274-12.945-54.085-12.945-54.085c-165.107-103.318-113.719-228.67-66.798-389.077
                c46.921-160.408,75.427-246.467,37.829-312.726c-37.674-66.259-126.276-61.328-139.913-90.066
                c127.047-158.404,418.509-236.22,418.509-236.22c-9.17,63.562-4.392,130.283,103.934,149.313
                c215.032,22.497,323.462-204.439,323.462-204.439s34.847-1.153,89.708,8.741c59.26,10.687,176.754,42.284,268.883,74.707
                c80.743,22.112,80.538,78.076,64.666,160.206c-4.853,25.194-10.863,52.083-15.64,80.435
                c-16.872,102.547-62.482,474.906-81.975,626.299c-9.939,77.045-23.191,178.514-10.94,318.967
                c14.638,71.421,27.735,128.511,33.282,149.93C3385.677,2968.841,3491.343,3375.626,3505.751,3618.561z" class="colorfff svgShape"></path><path fill="#e5e6eb" d="M2399.234,3043.23c70.922-16.657,96.272-49.302,112.227-48.106
                  c0,0,11.517,167.571,51.041,173.146c144.655-20.485,615.801-52.442,896.194,124.948
                  c-58.63-295.538-83.117-334.663-119.247-523.077c-17.407-216.43,18.417-350.045,40.04-549.048l-283.434-292.949
                  c0,0,22.222,347.625,31.717,450.761c5.711,62.027-42.811,125.182-151.092,173.943
                  c-137.669-9.021-358.158-37.971-377.502-19.12c-20.392,19.87-78.478,178.227-81.454,262.19
                  c-25.653-2.216-169.937-13.692-319.204-25.507c-100.694,113.887-177.904,255.681-196.779,406.474
                  c25.941-50.921,71.812-99.85,143.91-129.614C2254.84,3050.461,2365.305,3051.199,2399.234,3043.23z" class="colore5e6eb svgShape"></path><path fill="#e5e6eb" d="M2268.622,2513.592c17.69,24.591,43.285,48.022,79.065,70.423
                  c0,0,87.431,19.047,163.774-1.307C2511.461,2582.708,2356.035,2572.387,2268.622,2513.592z" class="colore5e6eb svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#f6af9a" d="M3104.287,1794.062c0.673-19.648,4.084-39.531,10.507-59.153
              c36.647-111.943,157.103-172.983,269.046-136.336c92.896,30.411,121.689,102.092,146.782,211.621
              c0,0,61.463,388.604,70.485,599.441c9.021,210.836,11.943,478.958,5.168,499.651
              c-26.008,79.444-111.492,122.762-190.936,96.755c-66.934-21.912-108.217-86.045-104.006-153.213
              c-0.004,0-190.244-751.42-206.018-1029.443C3104.301,1813.711,3103.95,1803.917,3104.287,1794.062L3104.287,1794.062z" class="colorf6af9a svgShape"></path><path fill="#ea9a88" d="M3286.618,2752.758c11.505,47.313,19.83,80.636,23.137,93.803l94.018-100.625L3286.618,2752.758
              z" class="colorea9a88 svgShape"></path><path fill="#ffffff" d="M3242.482,1574.421c0,0-219.806,27.585-159.787,379.431
              c60.019,351.846,168.362,756.722,197.159,900.067c28.797,143.345,139.858,202.021,232.962,168.838
              c93.103-33.183,121.34-101.311,119.701-196.495c-1.639-95.184-43.447-851.931-116.297-1098.757
              C3464.6,1532.527,3242.482,1574.421,3242.482,1574.421z" class="colorfff svgShape"></path><path fill="#d7d6db" d="M3213.089,2567.213c9.723,40.876,18.95,79.342,27.39,114.699l163.293,6.633
              C3385.734,2647.393,3289.387,2580.934,3213.089,2567.213z" class="colord7d6db svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#203f5b" d="M2381.493,717.884c0,0-17.118,49.601-12.958,88.631c4.16,39.028,16.364,52.465,2.502,86.388
              c-13.861,33.923-26.316,54.506-15.894,96.198c10.425,41.693,13.549,79.142-1.246,97.879c0,0,33.63-17.551,49.07-52.507
              c15.438-34.957-7.286-76.48,18.112-113.458c25.4-36.975,66.802-78.809,64.539-126.984
              C2483.359,745.857,2381.493,717.884,2381.493,717.884z" class="color203f5b svgShape"></path><path fill="#f6af9a" d="M2860.117,433.281c0,0,330.182,43.743,285.761,434.982
              c-42.67,375.825-388.023,653.9-651.46,549.21c-83.175-38.813-121.335-240.267-96.456-535.276
              S2568.698,395.292,2860.117,433.281z" class="colorf6af9a svgShape"></path><path fill="#ea9a88" d="M2594.014 1109.576c0 0 16.342-26.846 85.306-16.796 56.059 8.167 97.285 21.927 92.429 56.888C2769.829 1195.595 2555.669 1175.922 2594.014 1109.576zM2472.895 1101.239c-.625 14.946-43.929 27.975-80.539 24.075-1.365-26.023-1.997-53.499-1.878-82.332C2436.82 1051.931 2477.152 1070.605 2472.895 1101.239z" class="colorea9a88 svgShape"></path><path fill="#1f334c" d="M2683.429 1024.537c-2.537 20.314-16.949 35.239-32.19 33.337-15.243-1.905-25.542-19.917-23.007-40.231 2.537-20.316 16.952-35.241 32.194-33.336C2675.668 986.209 2685.967 1004.221 2683.429 1024.537zM2488.621 995.283c-2.442 19.568-16.323 33.943-31.004 32.11-14.681-1.833-24.601-19.181-22.156-38.748 2.444-19.565 16.325-33.94 31.006-32.107C2481.145 958.371 2491.064 975.718 2488.621 995.283z" class="color1f334c svgShape"></path><path fill="#e57e73" d="M2524.858,1245.875c24.153,4.309,47,3.203,61.915,1.516
                  c31.57-3.571,32.795-7.642,32.92-11.139l-0.3-2.123c-0.66-4.681-5.079-7.876-9.731-7.035
                  c-0.389,0.107-39.498,10.547-81.983,2.966c-42.15-7.521-63.745-23.366-63.958-23.527c-3.545-2.641-8.577-1.934-11.237,1.602
                  c-2.659,3.539-1.967,8.553,1.562,11.224C2455.026,1220.101,2478.575,1237.617,2524.858,1245.875z" class="colore57e73 svgShape"></path><path fill="#ea9a88" d="M2531.412,1290.14c-21.943-1.455-37.677-9.943-38.54-10.417
                  c-4.222-2.322-5.765-7.627-3.445-11.851c2.32-4.216,7.616-5.761,11.832-3.456c0.412,0.221,23.053,12.18,49.697,7.298
                  c4.73-0.869,9.288,2.269,10.158,7.01c0.867,4.74-2.271,9.288-7.011,10.157
                  C2546.093,1290.35,2538.435,1290.606,2531.412,1290.14z" class="colorea9a88 svgShape"></path><path fill="#e57e73" d="M2535.327,1162.981c-11.251-1.066-31.558-3.922-42.745-11.173
                c-15.158-9.823-7.983-23.401,0.325-39.125l1.047-1.977c50.068-94.965,47.135-126.351,47.122-126.773
                c-0.134-4.84,3.661-8.915,8.499-9.085c4.856-0.162,8.908,3.566,9.115,8.402c0.077,1.863,3.668,35.499-49.148,135.675
                l-1.051,1.993c-3.232,6.115-6.875,13.007-7.094,15.536c9.167,6.006,30.829,8.93,42.492,9.496
                c4.822,0.243,8.611,4.364,8.376,9.225c-0.232,4.86-4.358,8.609-9.221,8.377
                C2542.118,1163.509,2539.281,1163.355,2535.327,1162.981z" class="colore57e73 svgShape"></path><path fill="#293d5c" d="M2619.237 908.943c0 0-12.856-2.084-13.811 6.512-.953 8.596-.746 27.82 4.549 30.669 5.298 2.847 72.162 6.931 97.911 9.893 25.749 2.962 66.301 13.376 68.594 10.588 2.29-2.786-12.253-20.251-40.789-30.959C2711.438 926.543 2653.502 909.879 2619.237 908.943zM2401.3 912.537c0 0-12.494-.666-12.54-8.491-.057-10.039 42.237-21.647 112.543-10.816 20.462 4.195 15.966 28.469 9.646 39.229C2505.115 942.394 2476.814 919.495 2401.3 912.537zM3189.48 1058.808c0 0 57.255-44.332 112.721-6.232 55.468 38.1 30.069 101.315 30.069 101.315s32.711 9.86 29.784 33.787c0 0 34.352 26.557 15.776 96.301-18.574 69.747-95.037 83.51-95.037 83.51s14.488 58.211-18.762 95.26c-33.253 37.051-122.778-14.257-122.778-14.257s-56.733 27.062-77.736.21c0 0-143.847 47.814-115.847-101.751 27.998-149.568 112.76-144.229 112.76-144.229s-35.145-52.279 8.354-94.357c43.497-42.08 80.01-16.094 80.01-16.094S3143.089 1040.996 3189.48 1058.808z" class="color293d5c svgShape"></path><path fill="#25354e" d="M2952.327,1325.499c31.683-127.572,108.104-122.776,108.104-122.776
              s-35.145-52.279,8.354-94.357c43.497-42.08,80.01-16.094,80.01-16.094s-5.706-51.276,40.685-33.463
              c0,0,49.141-37.998,100.473-13.306c-11.877,5.416-22.732,14.382-24.033,29.183c-3.002,34.133,22.174,80.254-12.26,118.081
              c-34.436,37.827-59.417,44.905-63.692,65.485c-4.275,20.58-9.153,122.813-108.448,118.546c0,0-44.213,6.151-85.627-20.853
              C2985.648,1349.264,2969.844,1338.924,2952.327,1325.499z" class="color25354e svgShape"></path><path fill="#293d5c" d="M2593.995,632.365c0,0-12.099,34.459,13.727,72.536c25.826,38.074,57.224,39.487,67.316,54.871
              c10.095,15.385,2.729,55.769,40.353,91.185c37.623,35.416,75.231,46.293,95.051,73.92c19.816,27.63,22.531,58.86,3.111,83.449
              c-19.418,24.59-46.181,59.923-31.465,87.513c14.716,27.59,32.369,55.792,19.032,80.623c0,0,29.666-29.619,27.6-68.894
              c-2.065-39.275,1.026-59.076,21.553-74.237c20.527-15.158,36.93-30.154,40.39-46.813c0,0-12.824,61.74,4.349,102.107
              c17.17,40.369,39.559,65.465,34.396,100.171c-5.165,34.705-13.994,87.052-1.532,100.885
              c12.461,13.833,7.998,59.929,24.988,71.637c16.993,11.706,73.054,22.329,96.875-13.613c0,0,62.628-1.304,87.226-36.063
              c24.598-34.759,16.322-83.5,16.322-83.5s76.024-60.879,90.86-102.777c14.838-41.897-25.818-92.253-25.818-92.253
              s-9.774-31.677,12.139-48.594c21.913-16.914,31.404-52.767,28.692-83.999c-2.715-31.23-29.596-59.304-44.182-77.667
              s-6.647-56.583,5.708-81.618s13.879-71.741-8.268-102.92c-22.147-31.177-49.143-43.942-52.211-53.778
              c-3.066-9.838-13.537-107.083-105.616-131.32c-35.649-10.47-86.215-47.552-130.519-55.732
              c-44.302-8.18-120.445-10.704-150.607,6.542c0,0-78.272-7.059-136.242,1.347c-57.97,8.405-58.692,26.655-76.242,37.323
              c-17.547,10.666-76.001,31.237-93.83,53.089c-17.828,21.855-11.195,53.899-25.675,74.405
              c-14.482,20.504-56.184,58.865-63.868,115.539c-7.681,56.672,32.313,106.637,32.313,106.637s10.645-62.448,46.538-85.148
              C2487.11,687.83,2566.397,701.257,2593.995,632.365z" class="color293d5c svgShape"></path><path fill="#25354e" d="M2657.524 556.581c-85.346 139.621 55.582 95.295 42.94 160.064 24.347-36.397-32.882-51.362-50.578-71.518C2635.125 618.452 2652.169 584.876 2657.524 556.581zM2751.844 747.251c-30.376 29.213.801 76.645 34.083 87.566 32.633 11.581 61.792 28.368 61.359 67.09C2873.156 810.421 2717.795 836.51 2751.844 747.251zM3200.103 985.264c-40.338 13.611-40.656 61.207-21.354 92.092 13.203 28.19 6.311 70.763-29.282 76.554 42.697 5.851 58.611-49.569 42.427-81.668C3174.57 1043.294 3169.288 1007.972 3200.103 985.264zM3099.367 1191.237c-15.875 16.656-10.495 45.587-21.257 64.552-7.966 19.516-30.842 32.689-49.823 19.574 15.112 26.361 53.897 10.836 62.587-13.56C3103.053 1238.666 3093.494 1214.677 3099.367 1191.237zM3102.046 604.687c9.218-10.773 34.216 24.585 38.35 31.963 28.418 52.763-60.405 121.276 12.03 154.915-53.306-43.22 24.435-88.332 4.19-145.951C3156.305 631.476 3111.97 587.013 3102.046 604.687zM3171.439 845.179c7.874 3.131 5.323 13.765 5.921 20.446.406 23.117-4.208 46.587-25.349 59.746 30.614 2.085 44.423-36.346 36.31-61.215C3186.215 856.427 3181.866 842.386 3171.439 845.179zM2987.703 793.876c7.996 26.957-19.32 51.967-18.384 80.1-2.604 61.838 96.471 56.967 59.829 157.769 20.76-24.684 21.099-63.149 4.186-90.216-12.402-21.641-39.921-31.162-48.959-53.363C2971.464 858.635 3005.19 821.725 2987.703 793.876zM3016.506 1146.306c-17.85-.575-49.001-17.493-43.892-38.359 10.156-50.616 20.875-83.232-36.941-105.916 40.311 33.813 34.528 44.302 25.52 91.717-2.633 13.079-4.655 29.994 7.269 39.592C2982.217 1143.309 3000.192 1152.671 3016.506 1146.306zM2575.508 548.333c-9.222 27.394-11.529 62.279-39.351 76.906-23.39 12.24-80.571-1.875-74.624 40.648C2473.683 608.771 2582.104 699.018 2575.508 548.333zM2772.764 486.868c28.066-21.824 66.119 10.622 77.29 36.878 5.936 27.508-10.843 57.387 5.461 83.56 9.449 20.477 32.927 13.901 49.718 19.217 28.78 14.729 25.741 51.56 20.467 79.028 15.708-31.417 15.575-84.409-26.677-93.681-20.391.194-34.654-4.216-36.573-28.648-2.148-24.269 9.58-51.815-5.904-73.929C2838.686 486.035 2797.307 458.495 2772.764 486.868zM3053.188 643.663c2.427-56.529-13.303-66.489-67.526-59.706-16.15.238-45.086-57.072-13.701-46.99-3.044-6.775-13.198-5.158-17.561-.295-12.354 19.984 6.309 55.804 28.621 60.97C3040.13 595.845 3035.238 586.585 3053.188 643.663zM2798.9 595.75c-23.276 24.995-40.685 58.992-35.617 94.483 3.152 35.521 40.858 69.305 76.539 53.755C2758.217 742.939 2770.363 646.872 2798.9 595.75zM2900.452 772.743c25.885 13.493-10.366 58.917-14.132 79.988C2910.099 840.911 2945.245 775.722 2900.452 772.743zM3074.688 788.491c-61.558 42.837 48.93 92.674-11.001 129.709 33.124.07 36.153-44.754 19.995-65.919C3066.618 830.754 3058.764 813.611 3074.688 788.491zM2999.731 1260.424c-28.076-6.26-33.358-34.269-35.819-59.055C2942 1225.397 2966.157 1277.223 2999.731 1260.424zM3110.885 1105.576c-17.807-8.894-19.787-26.422-29.414-42.151C3068.444 1082.192 3087.222 1118.288 3110.885 1105.576zM3313.472 1198.826c16.485 28.091 3.011 84.283-37.294 76.012C3321.644 1309.164 3355.397 1220.729 3313.472 1198.826zM3234.628 1325.62c-15.929 9.705-14.459 35.163-.805 46.353 3.485 3.65 9.915 3.868 9.146 9.172C3254.095 1379.517 3230.429 1347.462 3234.628 1325.62zM3180.164 1398.742c-15.432 19.32-37.589 7.266-57.839 5.056C3132.953 1428.565 3183.447 1432.19 3180.164 1398.742zM2665.521 426.693c-37.558-13.898-103.76 10.015-83.173 58.418C2584.86 440.883 2631.554 436.269 2665.521 426.693zM2535.629 501.647c-1.09 4.856-7.37 4.48-11.044 6.259-13.409 4.784-26.709 8.827-39.864 15.167 15.349 9.91 36.884 4.505 48.497-8.674C2536.106 511.344 2539.803 505.062 2535.629 501.647zM2435.242 637.953c-32.049 6.749-37.861 47.702-15.226 68.26C2418.585 680.346 2419.183 659.493 2435.242 637.953zM2893.214 432.816c22.434 6.775 47.208-.607 65.724 13.826 26.577 30.692 51.632 67.941 99.026 57.076C2969.156 490.788 3002.673 404.508 2893.214 432.816z" class="color25354e svgShape"></path><path fill="#25354e" d="M2593.995,632.365c8.618-32.253,15.703-65.901,33.564-94.344
                c36.625-49.249,155.43-57.493,145.906-133.995c0.397,18.537-12.424,36.277-26.596,47.17
                c-39.267,23.133-84.43,36.541-119.731,67.277C2599.523,548.48,2596.251,593.507,2593.995,632.365z" class="color25354e svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#f6af9a" d="M2859.509,1038.252c0,0,47.409-95.089,101.898-72.067c54.49,23.025,12.086,113.269-7.99,145.222
              c-20.076,31.955-67.053,82.186-106.925,27.422C2822.887,1108.583,2859.509,1038.252,2859.509,1038.252z" class="colorf6af9a svgShape"></path><path fill="#e57e73" d="M2893.653,1083.196c-0.307-1.32-0.326-1.621-0.328-1.923
              c13.32-66.135,61.208-68.757,61.691-68.774c3.234-0.132,5.945,2.383,6.09,5.613c0.145,3.232-2.366,5.975-5.596,6.136
              c-1.345,0.07-28.13,1.901-43.344,35.354c12.953-7.267,26.959-8.189,27.865-8.24c3.241-0.188,6.007,2.291,6.196,5.527
              c0.191,3.239-2.281,6.018-5.519,6.215c-0.252,0.017-23.108,1.585-33.525,16.065c5.077,3.484,11.957,9.706,13.477,18.665
              c1.379,8.107-1.954,16.173-9.909,23.975c-1.455,1.428-3.462,1.944-5.32,1.558c-1.101-0.229-2.148-0.774-2.995-1.639
              c-2.275-2.318-2.239-6.043,0.079-8.319c5.03-4.931,7.235-9.5,6.556-13.578c-1.088-6.539-9.314-11.784-12.375-13.246
              C2893.75,1083.442,2893.696,1083.32,2893.653,1083.196z" class="colore57e73 svgShape"></path></g></g><g fill="#000000" class="color000 svgShape"><path fill="#f1d7b9" d="M1378.535,2393.806c0,282.675,229.152,511.827,511.827,511.827l258.113,0
                  c282.674,0,511.827-229.152,511.827-511.826C2660.302,2393.807,1378.535,2393.806,1378.535,2393.806z" class="colorf1d7b9 svgShape"></path><path fill="#e9ceb0" d="M2179.007,2495.049c0,0,192.503,22.733,142.223,58.611
                  c-216.784,13.553-274.582,69.053-287.426,182.143c-12.845,113.09-39.989,175.428-218.902,164.281
                  c24.628,3.64,49.821,5.55,75.461,5.55l258.113,0c282.674,0,511.827-229.152,511.827-511.826c0,0-77.165,0-193.622,0
                  C2312.377,2433.751,2179.007,2495.049,2179.007,2495.049z" class="colore9ceb0 svgShape"></path><ellipse cx="2019.418" cy="2393.807" fill="#e2bd93" rx="640.883" ry="112.867" class="colore2bd93 svgShape"></ellipse><path fill="#809260" d="M1893.033 2370.81c0 0-20.975-22.373-1.398-36.357 19.577-13.983 7.275-25.144 1.54-46.132s-34.892-46.159-11.224-65.736c23.668-19.577 53.033-15.382 58.627-48.942 5.593-33.56 60.129-40.552 82.502-4.195s32.162 40.552 57.332 40.552 61.527 22.374 61.527 41.95c0 19.577 13.983 36.384 33.56 36.37 19.577-.013 48.942 61.527 4.195 116.056L1893.033 2370.81zM2399.233 2244.959c0 0-16.78-62.926-61.527-53.137-44.747 9.788-60.129 64.891-47.544 126.833C2290.163 2318.656 2396.437 2355.428 2399.233 2244.959zM1583.999 2172.245c-22.373 6.991-6.992-40.552-41.95-43.349-34.959-2.796-46.145 26.569-71.315 46.146-25.17 19.577-57.332-12.585-97.884-26.569-40.552-13.983-81.104 12.585-81.104 60.128 0 47.544 40.552 85.299 82.502 128.648 28.607 29.561 39.004 71.469 42.726 95.143 43.912 21.259 123.064 39.537 225.022 52.642-6.939-42.027 4.274-135.079 27.128-174.354 23.597-40.552 19.751-83.901-9.614-127.25C1630.144 2140.083 1606.372 2165.253 1583.999 2172.245z" class="color809260 svgShape"></path><path fill="#8c9e68" d="M1473.53 2451.914c0 0-4.195-36.357-18.178-82.502s-20.975-65.722 9.089-74.112c30.064-8.39 45.446 30.764 45.446 30.764s25.17-23.128 55.934-16.458c30.764 6.67 20.975 58.408 11.187 84.977-9.788 26.569-5.593 79.706-5.593 79.706L1473.53 2451.914zM2024.477 2387.612c23.772-41.929-2.797-43.37-25.17-53.158-22.374-9.788-32.162-15.382-25.17-33.56 6.992-18.178-5.594-26.569-37.755-30.771s-40.552 16.788-55.934 33.568c-15.382 16.78-40.552 8.39-61.527-9.569-20.975-17.959-54.536-43.568-93.689 0-39.154 43.568 1.398 55.714 0 79.318-1.399 23.604-31.325-4.813-49.877-16.733-27.9-17.927-47.479 8.676-47.479 8.676-26.585 35.13 7.856 104.962 13.261 119.541 99.442 12.826 220.66 20.725 352.068 21.656C1999.354 2467.685 2010.027 2413.099 2024.477 2387.612z" class="color8c9e68 svgShape"></path><path fill="#96a96f" d="M1969.687,2424.539c-18.934-5.038-34.664-8.178-34.299-26.61
                c0.364-18.432-35.607-43.242-56.165-27.595c-20.558,15.647-12.482,39.419-6.403,54.205
                c6.079,14.786-23.7,35.141-44.258,22.659c-20.558-12.482-46.256,5.139-41.116,27.089c2.113,9.024,1.866,17.71,0.845,24.817
                c60.556,4.125,125.55,6.68,193.386,7.374c4.018-9.481,8.868-20.556,14.285-32.191
                C2011.381,2441.171,1988.621,2429.577,1969.687,2424.539z" class="color96a96f svgShape"></path><path fill="#8c9e68" d="M2019.418,2506.673c22.019,0,43.778-0.196,65.226-0.577
                c1.689-15.885,4.725-41.644,8.352-59.775c5.593-27.967,27.967-64.324,27.967-89.494c0-25.17,5.593-46.145-30.764-62.706
                c-36.357-16.56-67.12,5.374-68.519,27.747c-1.398,22.374-23.772,27.967-23.772,27.967l-28.222,156.503
                C1986.099,2506.56,2002.683,2506.673,2019.418,2506.673z" class="color8c9e68 svgShape"></path><path fill="#8c9e68" d="M2650.935,2387.271c27.967-20.656,44.747-39.666,39.154-68.615
                c-5.593-28.949-46.145-35.941-43.348-63.908c2.796-27.967-20.975-39.154-55.934-48.942c-34.958-9.788,0-83.9-65.722-88.096
                c0,0-40.552-6.992-78.307,19.577s-55.934,47.544-64.324,86.698c-8.39,39.153-9.789,69.917-33.561,76.909
                c-23.771,6.991-54.535-9.349-81.104-6.772c-26.569,2.577-51.739,24.95-53.137,51.519c-1.398,26.569-39.5,22.657-66.51,5.594
                c-27.01-17.063-90.104-8.39-95.698,47.543c-4.004,40.037,13.485,85.085,23.75,107.459
                c268.504-4.151,489.501-37.461,560.286-81.842C2635.899,2411.101,2634.705,2399.259,2650.935,2387.271z" class="color8c9e68 svgShape"></path><path fill="#809260" d="M2133.548,2442.125c-34.958-9.788-26.489-36.592-89.339-37.749
                c-62.85-1.156-72.869,47.537-110.624,57.326c-37.755,9.788-51.635,38.3-51.635,38.3c1.46,1.478,3.379,2.903,5.665,4.279
                c42.539,1.566,86.624,2.391,131.804,2.391c58.54,0,115.245-1.383,169.124-3.972
                C2195.27,2467.836,2167.771,2451.708,2133.548,2442.125z" class="color809260 svgShape"></path><path fill="#f1d9cf" d="M1784.586 2382.572l8.263 50.489c.728 4.446 4.766 7.574 9.252 7.167l57.33-5.202c5.234-.475 8.818-5.498 7.565-10.602l-11.121-45.287c-.943-3.84-4.386-6.541-8.341-6.541h-54.472C1787.765 2372.596 1783.73 2377.344 1784.586 2382.572zM2387.495 2341.497l8.263 50.489c.728 4.446 4.766 7.574 9.252 7.167l57.33-5.202c5.234-.475 8.818-5.498 7.565-10.602l-11.121-45.287c-.943-3.84-4.386-6.541-8.341-6.541h-54.472C2390.674 2331.521 2386.639 2336.269 2387.495 2341.497zM1602.773 2373.639l8.263 50.489c.728 4.446 4.766 7.573 9.252 7.167l57.33-5.202c5.234-.475 8.818-5.498 7.565-10.602l-11.121-45.287c-.943-3.841-4.387-6.541-8.341-6.541l-54.472 0C1605.952 2363.663 1601.918 2368.412 1602.773 2373.639zM2131.527 2413.17l27.778-51.006c2.305-4.232 7.274-6.253 11.878-4.831l49.4 15.258c5.688 1.757 8.64 8.019 6.374 13.525l-24.457 59.441c-2.176 5.288-8.296 7.726-13.512 5.382l-52.721-23.694C2130.89 2424.829 2128.707 2418.347 2131.527 2413.17z" class="colorf1d9cf svgShape"></path><path fill="#d26856" d="M1929.241,2306.983c0,0-4.038,93.802,79.085,99.116
                    c83.123,5.315,101.302-55.229,101.302-55.229S2018.735,2357.768,1929.241,2306.983z" class="colord26856 svgShape"></path><path fill="#e07460" d="M2104.446,2351.1c-19.922,0.552-94.24-0.46-169.059-40.73
                    c3.257,14.712,19.26,72.677,70.186,78.626C2067.787,2396.264,2096.966,2361.823,2104.446,2351.1z" class="colore07460 svgShape"></path><path fill="#d26856" d="M1550.439,2354.03c0,0-21.964,68.362,14.804,119.407
                    c49.476,8.752,107.053,16.082,170.585,21.612c21.717-20.465,31.354-44.533,31.354-44.533
                    S1660.908,2481.279,1550.439,2354.03z" class="colord26856 svgShape"></path><path fill="#e07460" d="M1557.435,2361.862c-2.666,17.355-8.914,78.717,36.109,116.288
                    c36.174,5.669,76.02,10.626,118.829,14.75c25.26-11.978,43.249-30.546,48.43-41.023
                    C1736.93,2456.006,1649.398,2462.507,1557.435,2361.862z" class="colore07460 svgShape"></path><path fill="#d26856" d="M2302.773,2495.069c45.288-83.227-7.017-124.735-7.017-124.735
                    c-14.139,78.408-127.001,126.682-145.146,133.971C2204.076,2502.346,2255.099,2499.215,2302.773,2495.069z" class="colord26856 svgShape"></path><path fill="#e07460" d="M2275.337,2497.315c13.974-16.287,29.221-38.966,29.486-60.64
                    c0.374-30.713-7.557-49.661-11.305-56.872c-21.004,72.825-125.529,117.519-142.908,124.502
                    C2193.951,2502.717,2235.689,2500.359,2275.337,2497.315z" class="colore07460 svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#d26856" d="M2381.151,2486.987c62.349-7.521,116.77-16.932,160.593-27.765
                    c72.896-68.788,7.462-157.763,7.462-157.763C2525.235,2419.852,2404.53,2476.951,2381.151,2486.987z" class="colord26856 svgShape"></path><path fill="#e07460" d="M2535.367,2446.543c47.323-51.944,20.011-120.769,12.176-137.663
                    c-25.437,105.297-127.438,160.176-160.162,175.322c1.918,0.34,4.337,0.732,7.162,1.125
                    c43.557-5.547,82.996-12.035,117.359-19.294C2520.275,2460.805,2528.21,2454.399,2535.367,2446.543z" class="colore07460 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#d7d6db" d="M2597.908,2590.452c0,0-74.543,190.341,0.019,367.468c0,0,136.906-71.08,136.906-172.092
            C2734.833,2684.816,2691.161,2619.445,2597.908,2590.452z" class="colord7d6db svgShape"></path><path fill="#f6af9a" d="M2606.407,2684.971c0.014,0.002,260.914,4.592,476.012,3.563
              c238.843-1.143,287.144-4.01,384.181,21.536c13.325,1.937,26.103,5.554,38.102,10.658
              c55.435,23.609,90.051,81.246,88.331,145.22c-2.769,102.931-101.251,153.295-186.683,149.724
              c-274.703-11.482-688.401-151.774-688.401-151.774c-3.148-0.738-143.692-18.416-146.697-19.489
              c-33.414-11.985-57.229-43.807-57.229-81.202C2514.023,2715.595,2598.606,2682.65,2606.407,2684.971z" class="colorf6af9a svgShape"></path><path fill="#f6af9a" d="M2734.833,2774.864c-2.334-32.202-61.682-62.648-90.699-71.823
                c-0.479-0.154-76.191-58.358-132.674-68.504c-2.529-0.455-77.644,1.161-152.691,2.764
                c-49.576,1.059-120.993-21.158-127.567,5.784c-4.092,16.774,57.729,40.747,139.69,54.125
                c29.742,4.854,36.357,24.076,36.277,24.207c-39.683,65.955-68.547,61.317-107.168,71.406
                c-60.54,15.814-210.311-55.875-233.421-49.839c-23.111,6.036-20.637,21.254-11.192,31.233
                c3.136,3.314,9.195,9.497,16.209,16.668c-5.112,10.027-12.179,35.82,28.762,64.221c0,0-15.32,31.601,53.855,55.01
                c0,0,7.729,28.376,42.253,35.566c22.765,4.741,131.681,26.173,156.182,25.694c6.586-0.129,20.756-7.542,37.913-18.266
                c41.503-19.521,105.738-58.246,129.894-67.639c33.08-12.864,79.132-32.489,117.013-31.445
                c19.143,1.411,30.007,4.118,39.219,3.45C2718.854,2854.417,2737.89,2817.029,2734.833,2774.864z" class="colorf6af9a svgShape"></path><path fill="#e57e73" d="M2070.661 2792.821c44.951 15.12 92.321 30.557 137.165 46.364 40.838 11.61 83.554 8.68 125.893 8.234l.206 1.141c-44.47 12.73-94.489 16.299-137.545-3.364-41.322-16.83-79.42-32.344-120.322-49.783L2070.661 2792.821zM2154.215 2910.115c63.35 7.989 126.788 22.771 190.711 25.726l.068 1.157c-31.024 10.81-65.952 6.322-96.857-3.236-27.683-6.641-51.969-12.605-79.165-19.638L2154.215 2910.115zM2110.155 2857.829c75.668 26.339 144.57 36.976 224.455 42.601l.084 1.156c-80.993 16-160.625-16.007-234.333-46.481L2110.155 2857.829z" class="colore57e73 svgShape"></path><path fill="#ffffff" d="M2664.704,2781.287c-1.291,124.978-66.777,176.633-66.777,176.633
            c32.98,17.42,765.089,112.679,898.07,65.106c132.981-47.573,126.465-188.262,81.748-250.259
            c-44.717-61.997-185.452-102.024-260.032-112.46c-74.581-10.436-709.302-74.727-719.785-71
            C2588.339,2592.714,2666.326,2624.29,2664.704,2781.287z" class="colorfff svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#f6af9a" d="M1384.185,2710.055c0,0-32.263-18.05-30.579-37.57c1.684-19.519,24.145-42.555,60.947-56.619
            c36.802-14.064,120.209-47.412,138.854-25.634c9.27,12.68-2.813,29.685-2.813,29.685s41.426-11.997,49.779,3.687
            c8.353,15.684-14.342,37.334-14.342,37.334s28.534,4.433,34.223,17.006c5.69,12.573-16.985,42.768-16.985,42.768
            s38.805,1.983,45.88,14.321c7.075,12.338-51.528,82.809-78.251,110.127c-26.723,27.319-79.827,33.455-84.791-12.723
            c0,0-60.413-7.587-53.828-52.87C1432.279,2779.568,1370.929,2766.44,1384.185,2710.055z" class="colorf6af9a svgShape"></path><path fill="#e57e73" d="M1550.594 2619.917c0 0-59.262 24.764-86.962 38.055-28.414 13.204-60.039 27.475-79.447 52.083 29.99-9.793 57.637-25.796 84.576-42.373C1468.086 2666.685 1550.594 2619.917 1550.594 2619.917zM1586.031 2660.939c0 0-68.359 44.899-101.266 67.48-36.342 28.866-52.485 51.149-52.485 51.149s23.091-10.279 60.807-40.408c12.208-10.955 42.881-35.869 55.925-46.634C1547.716 2692.436 1586.031 2660.939 1586.031 2660.939zM1603.269 2720.713c-32.446 31.423-74.211 62.14-104.49 95.367-9.155 9.589-12.672 16.358-12.672 16.358s23.57-10.536 49.388-35.527C1558.502 2774.64 1588.889 2745.484 1603.269 2720.713z" class="colore57e73 svgShape"></path></g></g></g></svg></g></svg></div><section><p class="text-center"><strong>Jedz regularnie, najlepiej 5 posiłków dziennie, co 3-4 godziny. Regularne posiłki pomogą opanować poranne nudności i ograniczyć napady głodu.</strong></p><p>Jedz warzywa lub owoce do każdego posiłku, błonnik pokarmowy pozwoli uniknąć nieprzyjemnych zaparć. Skropienie oliwą warzyw i owoców pozwoli na lepsze wchłanianie witamin rozpuszczalnych w tłuszczu do organizmu. W II i III trymestrze jedz ok. 400 g warzyw i 400 g owoców dziennie. Pamiętaj, o urozmaiceniu.</p></section><section><ul class="text-start"><li>Jedz dla dwojga, nie za dwoje.</li><li>Zacznij dzień od obfitego śniadania, najlepiej bogatego w produkty białkowe i węglowodany złożone.</li><li>Wybieraj zdrowe tłuszcze nienasycone, bogate w kwasy omega-3 i omega-6 tłuszcze roślinne (m.in. oliwę z oliwek, olej rzepakowy).</li><li>Stawiaj na zdrowe przekąski, pomiędzy posiłkami jedz warzywa, owoce lub orzechy.</li><li>Wybieraj produkty najwyższej jakości.</li><li>Pij dużo płynów około 2,3 l dziennie. Odpowiednie nawodnienie organizmu mobilizuje do pracy nerki, wspomaga oczyszczanie z toksyn i ułatwia przemianę materii. Do gaszenia pragnienia wybieraj wodę.</li><li>Nie zapominaj o myciu produktów, z których przygotujesz potrawy, a także dbaj o czystość naczyń i sprzętów kuchennych, które miały kontakt z surowym mięsem, jajami i rybami.</li></ul><p>Prawidłowa dieta w czasie ciąży powinna zapewnić zdrowie nie tylko przyszłej mamie, ale przede wszystkim rosnącemu dziecku. Zwracaj szczególną uwagę na to, co jesz i zadbaj o pełnowartościową i zbilansowaną dietę w tym szczególnym dla Ciebie okresie.</p></section></article>',
        '<h3>content1</h3>',
        '12/12/2023'),
       ('health', 'Mdłości w ciąży – kiedy się pojawiają i jak sobie z nimi radzić?', 'Title 2',
        'Ciąża dla wielu kobiet nie jest najłatwiejszym okresem w życiu. Zwłaszcza w momencie, kiedy ich dzień determinowany jest przez nudności i wymioty.',
        'Description 2', 'mdlosci_i_wymioty_w_ciazy.webp',
        '<article><h1>Mdłości w ciąży – kiedy się pojawiają i jak sobie z nimi radzić?</h1><div class="d-flex justify-content-center"><svg id="SvgjsSvg1001" width="550" height="550" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"><defs id="SvgjsDefs1002"></defs><g id="SvgjsG1008"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 2000 2000" viewBox="0 0 2000 2000" width="550" height="550"><path fill="#d9ecf2" d="M1611.365,269.252c56.266,68.091,21.403,158.207,18.67,236.484			c-0.373,10.678-16.946,10.744-16.649,0c1.991-71.917,37.612-162.03-13.209-225.295
			C1593.884,272.608,1604.839,261.355,1611.365,269.252z" class="colord9ecf2 svgShape"></path><path fill="#d9ecf2" d="M1422.576,1839.098c0,0,149.957-198.33,203.167-401.497
			c53.21-203.167,65.304-476.476,9.675-498.243c-55.629-21.768-106.421,24.187-106.421-45.954
			c0-70.141,70.141-386.985,74.978-510.337c4.837-123.352-53.21-210.423-440.196-135.445
			C776.794,322.6,418.833,467.719,365.622,588.652c-53.21,120.933,101.584,476.476,116.096,553.873
			c14.512,77.397-55.629,120.933-118.514,215.26c-62.885,94.328,28.63,483.568,28.63,483.568L1422.576,1839.098z" class="colord9ecf2 svgShape"></path><path fill="#becfdf" d="M371.598,1743.225c0.396,2.13,0.791,4.234,1.184,6.315h17.095v83.241
			c1.247,5.552,1.957,8.571,1.957,8.571l4.358-0.01v-91.803h190.402v91.386l6.315-0.014v-91.373h190.402v90.956l6.315-0.014v-90.942
			h190.402v90.526l6.315-0.014v-90.512h190.402v90.095l6.315-0.014v-90.081h190.402v89.665l6.315-0.014v-89.651h103.21
			c1.294-2.076,2.6-4.181,3.917-6.315h-107.127v-190.402h190.402v36.188c2.126-4.623,4.233-9.276,6.315-13.962v-22.227h9.591
			c0.879-2.1,1.751-4.206,2.619-6.315h-12.21v-190.402h67.738c0.411-2.103,0.817-4.208,1.219-6.315h-68.958v-190.402h93.137
			c0.129-2.112,0.255-4.219,0.372-6.315h-93.51V962.671h78.488c-0.966-2.249-1.977-4.352-3.03-6.315h-75.459v-22.554
			c-2.158,0.15-4.264,0.294-6.315,0.414v22.14h-190.402V765.953h166.116c0.354-2.092,0.712-4.196,1.073-6.315h-167.188V569.236
			h190.402v57.409c2.13-12.266,4.244-24.546,6.315-36.751v-20.657h3.474c0.351-2.109,0.7-4.214,1.048-6.315h-4.522V372.518h27.731
			c0.018-2.117,0.015-4.223-0.012-6.315h-27.719v-91.598c-1.977-2.411-4.079-4.758-6.315-7.036v98.635h-190.402V220.137
			c-2.088,0.065-4.191,0.138-6.315,0.221v145.845h-190.402V243.971c-2.093,0.387-4.202,0.782-6.315,1.18v121.052H986.344v-78.857
			c-2.108,0.537-4.212,1.077-6.315,1.617v77.24H789.627v-21.372c-2.11,0.703-4.215,1.408-6.315,2.115v19.257h-55.012
			c-5.75,2.095-11.458,4.2-17.115,6.315h72.127V562.92H592.909V421.38c-2.116,0.972-4.221,1.945-6.315,2.919V562.92H396.192v-17.366
			c-2.2,2.287-4.299,4.57-6.315,6.848v10.518h-8.683c-1.611,2.11-3.132,4.215-4.576,6.315h13.259v190.402h-22.925
			c0.424,2.099,0.857,4.204,1.298,6.315h21.627v86.982c2.059,7.319,4.167,14.637,6.315,21.939v-108.92h190.402v190.402H421.68
			c0.694,2.113,1.386,4.218,2.079,6.315h162.835v190.402H483.197c0.197,2.13,0.32,4.233,0.386,6.315h103.01v190.402H396.192v-37.059
			c-2.097,2.652-4.202,5.342-6.315,8.078v28.98h-21.24c-1.437,2.078-2.87,4.186-4.301,6.315h25.541v190.402h-45.714
			c0.166,2.101,0.338,4.207,0.515,6.315h45.199v190.402H371.598z M586.594,759.638H396.192V569.236h190.402V759.638z
			 M1379.779,1356.106h190.402v190.402h-190.402V1356.106z M1379.779,1159.388h190.402v190.402h-190.402V1159.388z
			 M1379.779,962.671h190.402v190.402h-190.402V962.671z M1379.779,372.518h190.402V562.92h-190.402V372.518z M1183.062,1552.823
			h190.402v190.402h-190.402V1552.823z M1183.062,1356.106h190.402v190.402h-190.402V1356.106z M1183.062,1159.388h190.402v190.402
			h-190.402V1159.388z M1183.062,962.671h190.402v190.402h-190.402V962.671z M1183.062,765.953h190.402v190.402h-190.402V765.953z
			 M1183.062,569.236h190.402v190.402h-190.402V569.236z M1183.062,372.518h190.402V562.92h-190.402V372.518z M986.344,1552.823
			h190.402v190.402H986.344V1552.823z M986.344,1356.106h190.402v190.402H986.344V1356.106z M986.344,1159.388h190.402v190.402
			H986.344V1159.388z M986.344,962.671h190.402v190.402H986.344V962.671z M986.344,765.953h190.402v190.402H986.344V765.953z
			 M986.344,569.236h190.402v190.402H986.344V569.236z M986.344,372.518h190.402V562.92H986.344V372.518z M789.627,1552.823h190.402
			v190.402H789.627V1552.823z M789.627,1356.106h190.402v190.402H789.627V1356.106z M789.627,1159.388h190.402v190.402H789.627
			V1159.388z M789.627,962.671h190.402v190.402H789.627V962.671z M789.627,765.953h190.402v190.402H789.627V765.953z
			 M789.627,569.236h190.402v190.402H789.627V569.236z M789.627,372.518h190.402V562.92H789.627V372.518z M592.909,1552.823h190.402
			v190.402H592.909V1552.823z M592.909,1356.106h190.402v190.402H592.909V1356.106z M592.909,1159.388h190.402v190.402H592.909
			V1159.388z M592.909,962.671h190.402v190.402H592.909V962.671z M592.909,765.953h190.402v190.402H592.909V765.953z
			 M592.909,569.236h190.402v190.402H592.909V569.236z M396.192,1552.823h190.402v190.402H396.192V1552.823z M396.192,1356.106
			h190.402v190.402H396.192V1356.106z" class="colorbecfdf svgShape"></path><path fill="#877698" d="M383.804,1841.352c0,8.46,20.505,10.212,507.272,7.659c483.199-2.534,546.499,0.801,546.499-7.659
		c0-8.46-261.781-6.291-541.94-6.291S383.804,1832.892,383.804,1841.352z" class="color877698 svgShape"></path><defs><path id="a" d="M1401.765,347.65c-2.475-1.238-78.039-9.222-156.592-8.324c-78.553,0.898-135.483,2.136-137.958,8.324
							s-7.536,345.516-7.536,345.516s2.585,61.598,5.061,65.31c2.475,3.713,285.159,12.649,290.473-4.814
							C1400.528,736.199,1401.765,347.65,1401.765,347.65z" fill="#000000" class="color000 svgShape"></path></defs><clipPath id="b"><use overflow="visible" xlink:href="#a"></use></clipPath><g clip-path="url(#b)" fill="#000000" class="color000 svgShape"><path fill="#814915" d="M1595.572,569.443c-2.203-4.047-5.333-7.651-9.23-10.141c-1.875-1.198-3.954-2.125-6.106-2.697
							c-2.71-0.719-5.595-0.553-8.271-1.374c-7.567-2.32-6.809-12.901-7.595-19.139c-0.452-3.588-1.121-7.36-3.181-10.419
							c-2.32-3.447-6.063-5.342-10.192-5.479c-5.118-0.17-10.055,1.868-15.014,2.811c-1.415,0.269-2.815,0.392-4.185,0.37
							c-0.009-0.026-0.015-0.053-0.023-0.079c-2.963-9.095-8.256-17.359-15.802-23.312c-7.135-5.629-15.747-9.064-24.635-10.741
							c-13.981-2.639-28.984-1.61-42.822,2.422c-14.105,5.194-34.76,20.231-49.187,25.279c-4.976,1.742-9.926,3.559-14.901,5.303
							c-4.277,1.5-8.806,3.54-13.362,3.961c-1.744,0.161-3.756,0.119-5.223-0.97c-2.088-1.549-1.952-4.364-1.843-6.688
							c0.249-5.334,4.658-26.382,4.664-31.724c0.017-18.275-3.448-38.249-17.297-51.404c-6.541-6.213-15.014-9.882-23.805-10.926
							c-0.894-0.179-1.795-0.331-2.706-0.444c-5.209-0.642-10.571,0.004-15.379,2.087c-3.155,0.992-6.204,2.35-9.058,4.107
							c-0.046,0.028-0.064,0.068-0.106,0.099c-0.883-0.101-1.738-0.572-2.536-1.64c-1.896-2.54-2.582-5.788-4.246-8.466
							c-3.654-5.88-10.529-8.787-17.023-10.251c-6.396-1.442-13.052-1.744-19.556-0.931c-12.187,1.523-24.128,7.044-31.66,16.745
							c-3.234,0-6.485,0.783-9.49,2.211c-6.167,2.93-10.574,8.481-13.632,14.445c-5.597,10.915-9.377,24.429-7.689,36.748
							c0.809,5.904,3.17,11.432,7.347,15.664c-6.158,6.37-6.412,16.125-4.984,24.462c1.613,9.412,5.164,18.642,9.592,27.071
							c9,17.132,22.784,31.743,39.271,41.857c8.486,5.206,17.72,9.173,27.346,11.712c0.045,5.745,1.792,11.516,4.757,16.551
							c5.903,10.026,16.129,16.079,27.363,18.376c6.09,1.245,12.356,1.496,18.545,1.05c6.326-0.456,12.447-2.061,18.735-2.712
							c2.972-0.308,6.04-0.375,8.934,0.469c3.301,0.964,5.684,3.198,7.597,5.983c3.323,4.836,6.352,9.76,10.106,14.296
							c14.981,18.096,35.904,30.983,58.412,37.418c22.388,6.401,49.08,7.611,69.725-4.752c7.009-4.197,12.756-9.933,16.801-16.843
							c5.308-0.151,10.61-0.822,15.849-2.176c20.988-5.422,37.552-20.765,50.153-37.782
							C1592.26,613.335,1606.795,590.062,1595.572,569.443z" class="color814915 svgShape"></path><path fill="#dad0ff" d="M1425.954,492.913c-6.892,8.333-15.522,14.885-24.693,20.521
							c-8.674,5.33-18.712,11.41-29.264,10.864c0.025-0.025,0.051-0.049,0.076-0.075c6.517-5.182,13.088-10.311,19.47-15.654
							c5.887-4.928,11.613-10.523,14.639-17.718c1.183-2.815,2.441-6.514,0.688-9.379c-2.072-3.389-6.424-2.112-9.407-0.943
							c-5.612,2.2-10.443,5.844-14.497,10.237c-0.335-0.341-0.703-0.654-1.14-0.906c-2.193-1.265-4.881-0.649-6.935,0.598
							c-4.593,2.787-7.072,8.405-8.397,13.384c-1.706,6.407-2.221,13.213-1.996,19.844c-0.911,1.346-8.261,11.937-18.585,18.819
							c-11.04,7.36-1.698,12.738,2.265,13.305c3.963,0.566,16.418-13.305,19.532-22.08c0.92-2.593,1.258-4.719,1.247-6.422
							c5.877,4.005,14.969,3.179,21.277,1.142c7.771-2.508,14.357-7.567,20.15-13.187c1.462-1.417-0.773-3.649-2.233-2.233
							c-5.057,4.905-10.744,9.453-17.427,11.915c-3.388,1.248-6.956,1.977-10.574,1.957c-0.409-0.002-0.832-0.015-1.262-0.034
							c8.131-1.472,15.746-5.735,22.812-10.004c9.808-5.925,19.145-12.842,26.486-21.718
							C1429.473,493.591,1427.251,491.345,1425.954,492.913z M1385.073,496.11c-0.071-0.833-0.224-1.681-0.473-2.491
							c2.625-2.993,5.634-5.649,9.176-7.78c1.446-0.869,2.957-1.647,4.527-2.266c1.401-0.553,4.33-1.957,5.629-0.713
							c2.079,1.992-0.667,7.039-1.682,8.949c-3.225,6.065-8.429,10.8-13.657,15.124c-2.958,2.446-5.948,4.854-8.947,7.252
							c0.23-0.404,0.489-0.79,0.707-1.201C1382.993,508,1385.564,501.861,1385.073,496.11z M1381.955,496.904
							c0.009,0.259,0.012,0.509,0.008,0.741c-0.089,4.812-2.223,9.81-4.47,13.991c-2.045,3.805-4.627,7.248-7.624,10.331
							c-0.048,0.038-0.095,0.076-0.143,0.114C1372.898,513.459,1376.469,504.392,1381.955,496.904z M1367.672,518.568
							c0.107-3.23,0.398-6.453,0.952-9.641c0.769-4.429,1.98-8.99,4.695-12.658c1.282-1.732,3.132-3.675,5.393-3.929
							c0.994-0.112,1.688,0.241,2.177,0.83c-0.395,0.485-0.794,0.966-1.171,1.464
							C1374.288,501.807,1370.807,510.181,1367.672,518.568z" class="colordad0ff svgShape"></path><path fill="#e89067" d="M1332.604,531.484c0,0,11.032,12.035,33.097,16.047c22.065,4.012,43.628,8.024,43.628,8.024
								s-22.566,72.714-26.578,83.746c-4.012,11.033-78.485-29.134-78.485-29.134s9.783-7.975,10.786-20.01
								c1.003-12.035-28.584-32.094-28.584-32.094L1332.604,531.484z" class="colore89067 svgShape"></path><path fill="#1a1a1a" d="M1315.052,590.156c-0.193,2.317-0.715,4.479-1.427,6.468
								c5.649-1.168,11.006-4.213,15.34-7.806c5.78-4.791,10.769-11.229,12.693-18.587c1.627-6.223,0.389-12.927-1.21-19.026
								c-1.789-6.819-4.429-13.448-7.783-19.656c-0.019-0.021-0.062-0.065-0.062-0.065l-46.136,26.578
								C1286.468,558.062,1316.055,578.121,1315.052,590.156z" class="color1a1a1a svgShape"></path><path fill="#ecaf32" d="M1111.749,1065.74c0,0,13.947,81.666,30.495,118.789c16.549,37.123,28.013,27.304,34.75,17.021
							c2.643-4.034,5.96-13.862,13.12-15.248c21.985-4.255,32.109-21.051,31.168-24.811c-1.342-5.367,36.676-36.229,40.254-49.646
							c3.578-13.418,5.367-12.971,17.443-26.389c12.076-13.418,21.469-25.047,25.941-34.887c4.473-9.84,17.891-25.942,17.891-25.942
							s15.654,22.811,38.018,34.887c22.363,12.076,49.646,17.891,54.119,20.127c4.473,2.236-5.367,86.323-6.262,97.057
							c-0.895,10.734-8.956,88.103-8.956,88.103s-8.062,5.375,34.399,8.062c6.344,0.402,12.256,0.599,17.741,0.62
							c3.388,0.013,7.412-48.608,10.476-48.724c3.409-0.129,5.82,48.231,8.831,47.959c19.227-1.737,30.375-6.208,33.899-11.142
							c5.375-7.525,15.587-1.612,22.574,6.45c6.987,8.062,74.71-3.762,92.984-12.362c18.274-8.6,19.887-18.812,18.812-24.187
							c-1.075-5.375,2.15-3.762,16.125-1.612c13.974,2.15,59.123-30.636,70.41-45.686c11.287-15.049,0-26.337,5.912-33.324
							c5.912-6.987,4.3,4.3,16.124-2.688c11.824-6.987,30.636-45.148,36.011-55.898c5.375-10.75-54.823-115.827-98.359-181.937
							c-43.536-66.11-68.529-92.715-87.072-127.383c-18.543-34.667-10.266-121.633-14.297-148.238
							c-4.031-26.605-23.111-44.037-50.247-58.319c-28.971-15.248-126.733-22.344-126.733-22.344s-35.98,72.77-40.033,82.904
							c-14.462-5.875-56.268-29.49-63.024-26.787c-6.756,2.702-40.535,54.722-42.562,69.585
							c-2.027,14.863-16.214,154.033-18.241,160.789c-2.027,6.756-18.241,10.134-12.161,19.592c6.08,9.458,0.676,15.538-6.08,20.267
							c-6.756,4.729-10.809,5.405-7.431,15.539c3.378,10.134-4.054,26.348-4.054,26.348s-65.222,108.575-70.627,115.331
							c-5.405,6.756-10.443,3.572-12.47,8.977s-1.47,8.66-5.524,9.336C1121.064,1056.605,1110.102,1056.11,1111.749,1065.74z" class="colorecaf32 svgShape"></path><path fill="#1a1a1a" d="M1368.456,717.993c0,0,7.43,117.471,18.785,116.438c8.868-0.806,14.175-49.319,16.318-91.023
							c0.752-14.65,1.112-25.885,1.336-29.168C1405.755,701.611,1368.456,717.993,1368.456,717.993z" class="color1a1a1a svgShape"></path><path fill="#ffffff" d="M1589.057,637.092c-1.938,25.555-6.879,50.755-13.085,75.59
							c-3.101,12.409-6.514,24.737-10.04,37.031c-1.779,6.204-3.587,12.4-5.398,18.595c-1.659,5.677-3.189,11.495-5.997,16.737
							c-2.673,4.991-6.683,8.871-10.298,13.157c-3.229,3.828-5.613,7.901-7.641,12.458c-1.678,3.771-3.232,8.005-6.062,11.096
							c-3.641,3.979-8.49,3.231-13.36,4.256c-5.324,1.121-8.979,5.087-12.36,9.053c-3.188,3.74-6.678,6.953-11.035,9.291
							c-4.091,2.194-8.803,3.551-13.474,3.07c-4.986-0.513-8.585-3.945-13.085-5.751c-2.272-0.911-4.795-1.258-7.113-0.316
							c-2.514,1.022-3.781,3.109-4.981,5.407c-2.132,4.084-7.007,3.649-11.003,3.21c-12.67-1.391-25.27-3.878-37.598-7.094
							c-3.043-0.794-6.072-1.642-9.088-2.534c-3.906-1.155-5.574,4.938-1.679,6.09c12.55,3.71,25.341,6.572,38.284,8.513
							c5.571,0.836,11.521,2.131,17.163,1.332c2.424-0.343,4.713-1.17,6.613-2.747c0.946-0.784,1.734-1.77,2.354-2.829
							c0.557-0.951,0.908-2.195,1.65-3.019c1.314-1.461,3.767,0.077,5.1,0.809c2.398,1.316,4.618,2.848,7.177,3.855
							c4.695,1.847,9.967,1.819,14.819,0.622c5.098-1.258,9.789-3.831,13.895-7.058c4.077-3.204,6.892-7.491,10.68-10.965
							c1.913-1.755,4.065-2.741,6.649-3.063c2.913-0.363,5.871-0.363,8.648-1.431c4.334-1.666,7.417-5.112,9.667-9.076
							c2.239-3.943,3.722-8.257,5.84-12.262c2.582-4.884,6.497-8.687,10.04-12.855c3.957-4.656,6.809-9.73,8.906-15.466
							c2.162-5.915,3.748-12.056,5.508-18.1c3.717-12.766,7.38-25.55,10.762-38.41c6.688-25.428,12.26-51.205,14.981-77.386
							c0.34-3.267,0.63-6.538,0.878-9.813C1595.679,633.039,1589.363,633.058,1589.057,637.092z" class="colorfff svgShape"></path><path fill="#d59622" d="M1527.38 674.354c-19.886-3.143-39.771-6.285-59.657-9.428.285-9.929 1.615-19.756 3.997-29.403.974-3.945-5.114-5.629-6.089-1.679-2.432 9.85-3.828 19.948-4.186 30.088-2.239-.365-4.577-.891-6.79-.131-1.808.621-2.984 2.386-4.669 2.983-2.135.757-5.249-1.271-7.303-2.375-3.027-1.628-6.184-3.302-9.692-3.461-1.868-.085-3.599.447-5.278 1.21-1.972.896-3.039 1.118-4.855-.264-1.873-1.426-3.27-3.432-4.881-5.126-1.792-1.884-3.792-3.602-5.955-5.049-4.362-2.918-9.343-4.276-14.543-3.341-1.68.302-2.628 2.347-2.206 3.884.486 1.769 2.2 2.508 3.885 2.206 4.033-.725 8.001 1.284 11.081 3.726 3.455 2.739 5.823 6.606 9.431 9.153 1.651 1.166 3.628 1.969 5.675 1.973 2.369.004 3.984-1.342 6.155-1.91 2.6-.68 5.364 1.041 7.572 2.224 2.943 1.577 6.005 3.371 9.417 3.581 1.622.1 3.232-.228 4.687-.951 1.737-.863 2.756-2.702 4.821-2.51 5.047.469 10.119 1.59 15.127 2.381 5.413.855 10.825 1.71 16.237 2.566l36.339 5.742c1.682.266 3.397-.432 3.884-2.206C1529.999 676.737 1529.075 674.621 1527.38 674.354zM1225.271 1154.771c-13.215-28.017-28.721-54.942-46.409-80.397-7.108-10.229-14.57-20.209-22.331-29.952-1.063-1.335-3.355-1.11-4.466 0-1.319 1.319-1.066 3.127 0 4.466 27.136 34.062 50.195 71.386 68.618 110.846.2.429.391.862.59 1.292C1221.389 1159.745 1222.888 1157.564 1225.271 1154.771zM1186.984 1115.236c-12.86-22.042-28.273-42.548-45.861-61.038-1.403-1.475-3.634.76-2.233 2.233 17.411 18.303 32.637 38.58 45.367 60.399C1185.281 1118.584 1188.011 1116.996 1186.984 1115.236zM1186.489 1160.662c-7.41-22.623-17.384-44.398-29.75-64.742-3.566-5.865-7.333-11.605-11.277-17.222-1.16-1.651-3.899-.074-2.727 1.594 17.484 24.897 31.239 52.296 40.71 81.209C1184.074 1163.424 1187.124 1162.601 1186.489 1160.662zM1459.63 724.436c-2.031-9.441-4.221-18.846-6.419-28.249-.463-1.978-3.508-1.141-3.045.84 7.672 32.811 15.402 65.987 16.074 99.833.188 9.454-.208 18.912-1.27 28.309-.228 2.016 2.932 2 3.158 0C1471.944 791.375 1466.729 757.447 1459.63 724.436zM1431.49 677.485c-.669-1.905-3.72-1.085-3.045.839 8.368 23.851 13.377 48.785 14.813 74.022.115 2.02 3.273 2.034 3.158 0C1444.964 726.835 1439.951 701.598 1431.49 677.485zM1512.443 568.885c-1.271-.323-2.568-.641-3.889-.953-10.425 8.324-20.321 17.312-29.584 26.918-7.285 7.555-14.168 15.49-20.639 23.752-1.239 1.582.981 3.832 2.233 2.233C1475.703 601.506 1493.164 584.048 1512.443 568.885zM1267.605 664.306c-.553 1.113-1.08 2.201-1.57 3.253 8.478 12.386 17.458 24.429 26.959 36.055 5.854 7.163 11.899 14.167 18.118 21.015 1.369 1.508 3.597-.731 2.233-2.233C1296.756 704.13 1281.47 684.707 1267.605 664.306zM1420.778 555.186c-12.073 24.336-23.966 48.762-35.633 73.296-5.115 10.756-10.19 21.532-15.227 32.325-.854 1.83 1.867 3.435 2.727 1.594 16.727-35.841 33.898-71.475 51.487-106.901C1422.964 555.389 1421.845 555.284 1420.778 555.186zM1737.575 1136.605c-12.297-23.913-24.455-47.899-36.468-71.956-12.071-24.174-23.998-48.42-35.778-72.737-6.627-13.678-13.206-27.379-19.742-41.101-.873-1.834-3.596-.233-2.726 1.594 11.562 24.278 23.266 48.487 35.115 72.626 11.906 24.255 23.958 48.439 36.154 72.55 6.86 13.562 13.767 27.101 20.719 40.618C1735.778 1140.007 1738.504 1138.411 1737.575 1136.605zM1723.136 1141.017c-14.576-27.377-29.152-54.755-43.727-82.133-.956-1.794-3.683-.201-2.727 1.594 14.576 27.377 29.151 54.755 43.727 82.133C1721.365 1144.405 1724.092 1142.812 1723.136 1141.017zM1640.46 1217.572c-15.152-39.737-30.303-79.474-45.455-119.212l-12.907-33.85c-.717-1.88-3.771-1.064-3.045.839 15.152 39.737 30.303 79.474 45.455 119.212 4.302 11.283 8.604 22.567 12.907 33.85C1638.132 1220.292 1641.186 1219.476 1640.46 1217.572zM1517.592 1197.014c-.557-1.951-3.605-1.121-3.044.839 3.922 13.729 5.393 27.991 4.38 42.233-.145 2.028 3.014 2.019 3.158 0C1523.117 1225.584 1521.586 1210.991 1517.592 1197.014zM1441.094 1038.388c-29.071-29.853-47.883-69.25-53.385-110.522-1.374-10.303-1.904-20.726-1.577-31.115.34-10.78 2.197-21.654.737-32.42-.681-5.019-2.165-9.937-4.843-14.267-2.945-4.763-7.075-8.622-10.505-13.015-6.431-8.237-10.924-17.943-13.261-28.115-2.845-12.38-1.873-24.584 1.053-36.839 3.006-12.588 7.129-25.23 5.961-38.341-.179-2.008-3.338-2.027-3.158 0 1.079 12.106-2.463 23.781-5.336 35.398-2.66 10.758-4.314 21.525-2.957 32.606 1.259 10.284 4.565 20.287 9.804 29.236 2.726 4.657 6.012 8.865 9.566 12.911 3.869 4.406 7.403 8.831 9.179 14.513 3.283 10.512 1.541 21.847.871 32.607-.647 10.379-.42 20.808.641 31.152 2.13 20.784 7.551 41.144 15.93 60.278 9.423 21.517 22.655 41.333 39.047 58.166C1440.282 1042.079 1442.514 1039.845 1441.094 1038.388zM1464.278 1092.816c-.217-1.999-3.377-2.021-3.158 0 3.544 32.611 3.243 65.575-.898 98.115-.256 2.01 2.904 1.992 3.158 0C1467.521 1158.39 1467.822 1125.427 1464.278 1092.816zM1357.163 741.425c-.013-1.283-.218-2.616-1.055-3.622-.938-1.129-2.516-1.229-3.79-.689-.384.087-.752.225-1.073.463-.97.721-1.432 1.802-1.468 2.958-.668 2.465-.755 5.715 1.854 7.085 1.254.659 2.705.576 3.83-.293.872-.674 1.381-1.743 1.588-2.808C1357.24 743.542 1357.297 742.464 1357.163 741.425z" class="colord59622 svgShape"></path><path fill="#d59622" d="M1379.341 862.598c-.532-1.375-1.482-2.768-3.003-3.138-1.626-.396-3.143.607-3.84 2.042-.32.66-.508 1.376-.594 2.105-.129.158-.224.347-.267.564-.554 2.762.554 5.557 2.815 7.229 1.314.971 3.24 1.548 4.538.228 1.076-1.093 1.166-3.012 1.167-4.45C1380.156 865.636 1379.899 864.039 1379.341 862.598zM1420.268 1029.907c-.269-.768-.615-1.522-1.061-2.204-.291-.447-.625-.864-.98-1.264-.157-.223-.316-.445-.486-.658-.907-1.134-2.099-2.081-3.404-2.716-1.133-.552-2.26.133-2.376 1.363-.293 3.131 1.071 6.479 3.481 8.503.764.642 1.535 1.123 2.547 1.232 1.112.12 2.175-.535 2.529-1.604C1420.805 1031.698 1420.559 1030.738 1420.268 1029.907zM1458.683 1099.915c-.455-1.633-1.381-3.178-2.676-4.281-.651-.555-1.882-.659-2.39.178-.301.197-.546.483-.657.866-.214.743-.354 1.511-.433 2.284-.275 1.189-.42 2.406-.389 3.643.027 1.082.095 2.259.571 3.247.409.847 1.278 1.336 2.159 1.332.877.486 1.979.302 2.73-.418.625-.599.954-1.445 1.16-2.27C1459.131 1103.001 1459.096 1101.398 1458.683 1099.915zM1456.746 1197.216c-.712-1.655-2.304-3.796-4.352-2.787-.769.379-1.329 1.23-1.728 1.966-.379.696-.675 1.46-.84 2.236-.33 1.562-.287 3.25.268 4.758.563 1.529 1.758 3.423 3.548 3.349.023.017.043.037.066.054.743.545 1.692.055 2.16-.566C1457.801 1203.662 1457.99 1200.109 1456.746 1197.216z" class="colord59622 svgShape"></path><path fill="#e89067" d="M1348.461,510.318c-4.777-11.712-18.542-10.612-23.27-2.035
										c-3.731,6.677-9.252,2.73-10.839-1.052c-1.643-3.916-2.567-8.654-6.222-10.815c-3.253-1.924-14.008-2.531-38.759-19.454
										c-5.741-3.925-24.643-13.428-37.66-5.647c-1.353,10.431-4.985,20.634-12.728,27.587c-0.325,4.279-0.36,9.097-0.04,14.544
										c0.267,4.537,0.513,9.384,0.552,13.14c0.105,10.048,4.168,21.119,6.634,30.879c6.605,26.14,24.222,48.368,42.275,50.653
										c30.731,3.889,64.693-30.675,67.206-60.39C1335.609,547.727,1358.848,535.785,1348.461,510.318z" class="colore89067 svgShape"></path><path fill="#1a1a1a" d="M1281.873 521.822c.89-1.197 2.03-1.95 3.414-1.999.157-.03.311-.052.463-.069.057-.013.106-.039.168-.042.058-.003.103.013.16.012 4.767-.242 7.016 5.989 5.294 9.912-.158.906-.495 1.753-1.187 2.365-.684.605-1.577.951-2.497 1.045-.073.048-.136.103-.229.136-2.131.748-3.842-.276-4.961-2.022C1280.102 528.852 1279.782 524.635 1281.873 521.822zM1224.87 544.23c1.552-2.873 5.223-3.861 7.981-2.078.245.158.468.345.677.548.717.632 1.197 1.501 1.311 2.512.018.117.028.234.035.352.001.037.011.07.011.107-.006 1.789-.055 3.609-.888 5.239-1.607 3.144-5.728 3.271-8.13 1.014C1223.778 549.963 1223.545 546.684 1224.87 544.23z" class="color1a1a1a svgShape"></path><path fill="#ce5c48" d="M1260.104,561.436c0.104-1.473,1.451-2.663,2.934-2.544c1.459,0.118,2.92,0.236,4.379,0.353
										c1.477,0.119,2.648,1.445,2.544,2.934c-0.104,1.473-1.451,2.663-2.934,2.544c-1.459-0.117-2.919-0.235-4.379-0.353
										C1261.17,564.251,1259.999,562.925,1260.104,561.436z" opacity=".5" class="colorce5c48 svgShape"></path><path fill="#814915" d="M1296.712 498.461c-8.778-3.858-18.051-6.117-27.635-6.625-1.705-.09-3.158 1.516-3.158 3.158 0 1.785 1.448 3.067 3.158 3.158 8.391.445 16.747 2.379 24.448 5.763 1.56.685 3.39.457 4.32-1.133C1298.629 501.441 1298.281 499.151 1296.712 498.461zM1226.153 512.818c-1.27-1.165-3.206-1.237-4.466 0-2.906 2.855-5.319 6.273-6.957 10.006-.354.805-.562 1.549-.318 2.433.202.732.768 1.526 1.451 1.887.733.387 1.62.581 2.433.318.73-.236 1.564-.716 1.887-1.451.926-2.109 2.096-4.095 3.473-5.94.778-.977 1.605-1.911 2.497-2.787C1227.333 516.124 1227.402 513.965 1226.153 512.818z" class="color814915 svgShape"></path><path fill="#e89067" d="M1392.219,651.04c-3.249-2.32-18.004-11.205-24.048-16.832
								c-10.56-9.832-22.125-19.301-28.424-32.594c-3.021-6.375-5.587-12.907-10.757-17.919c-4.893-4.743-11.075-7.913-15.866-12.77
								c-5.298-5.372-10.95-9.515-15.786-15.3c-3.731-4.464-8.258-13.257-14.952-8.765c-6.2,4.16-5.347,11.632-2.928,17.78
								c2.018,5.129,5.32,9.539,9.082,13.52c-4.925-0.84-9.849-1.68-14.772-2.519c-7.312-1.247-14.796-2.956-22.235-1.9
								c-5.274,0.748-11.108,3.851-11.927,9.632c-0.858,6.054,3.675,10.19,8.946,11.628c-0.843,0.544-1.637,1.175-2.347,1.933
								c-2.966,3.169-3.99,7.56-2.353,11.634c1.665,4.14,5.181,6.895,9.078,8.843c0.505,0.253,1.023,0.482,1.534,0.723
								c-1.953,1.803-3.185,4.313-2.997,7.087c0.355,5.226,4.118,9.494,8.626,12.379c-1.573,3.859-0.819,8.541,1.455,11.994
								c2.786,4.229,7.21,6.982,11.485,9.509c4.923,2.911,10.064,5.411,15.354,7.582c5.302,2.175,10.897,3.69,16.047,6.223
								c9.968,4.903,22.618,7.895,30.708,15.308c8.833,8.095,61.084,50.444,68.513,54.732c0.832-9.981,2.532-52.672,2.317-59.06
								C1405.296,663.768,1398.041,655.199,1392.219,651.04z" class="colore89067 svgShape"></path><path fill="#dd8058" d="M1380.073,640.477c-10.329-5.419-19.571-12.654-27.306-21.387
								c-3.79-4.28-7.172-8.901-10.12-13.799c-3.206-5.325-5.564-11.064-8.549-16.503c-2.97-5.412-6.856-9.885-11.71-13.683
								c-4.623-3.618-9.681-6.678-14.117-10.533c-4.73-4.111-8.212-9.298-12.265-14.025c-3.556-4.146-8.796-9.534-14.588-5.861
								c-5.911,3.749-5.073,12.073-3.707,17.948c1.025,4.407,2.947,8.646,5.757,12.186c-2.878-0.588-5.769-1.109-8.674-1.547
								c-6.044-0.91-12.274-1.791-18.398-1.72c-5.265,0.061-10.89,1.372-14.604,5.37c-3.252,3.5-4.366,8.707-2.152,13.06
								c1.182,2.324,3.281,3.699,5.568,4.74c-2.011,1.67-3.589,3.878-4.377,6.37c-1.16,3.666,0.499,6.996,3.066,9.9
								c1.139,1.288,4.82,4.912,5.576,3.989c0.738-0.9-2.585-5.402-4.013-8.142c-0.705-1.283-0.664-3.62,0.112-4.993
								c0.776-1.374,2.859-4.152,4.809-4.972c1.851,0.759,3.7,1.525,5.551,2.286c2.816,1.159,4.044-3.422,1.259-4.567
								c-3.052-1.256-6.122-2.477-9.158-3.769c-2.328-0.99-4.408-2.145-4.786-4.872c-0.779-5.616,5.159-8.776,9.849-9.444
								c6.255-0.891,13.123,0.275,19.327,1.167c6.561,0.944,13.057,2.281,19.468,3.965c2.951,0.775,4.21-3.792,1.26-4.567
								c-0.558-0.147-1.994-1.281-2.459-1.656c-4.182-3.369-6.842-7.987-8.193-13.149c-0.931-3.56-2.884-12.865,2.465-14.023
								c2.575-0.557,5.073,2.724,6.557,4.361c1.928,2.127,3.682,4.401,5.464,6.65c3.599,4.541,7.453,8.497,12.089,11.985
								c4.272,3.214,8.846,6.044,12.848,9.606c4.422,3.937,7.382,8.728,9.98,14c2.458,4.988,4.818,9.982,7.799,14.689
								c2.882,4.549,6.147,8.872,9.717,12.903c7.975,9.006,17.615,16.54,28.264,22.128
								C1380.38,645.982,1382.776,641.896,1380.073,640.477z" class="colordd8058 svgShape"></path><path fill="#d59622" d="M1525.831,1041.995c-29.742,18.729-64.681,30.261-100.043,29.512
							c-16.643-0.352-33.41-3.465-48.78-9.963c-13.859-5.859-26.615-14.363-37.455-24.784
							c-21.888-21.043-35.71-50.156-33.917-80.859c1.109-19.001,7.407-37.253,13.841-55.006c3.17-8.745,6.949-17.5,9.225-26.532
							c2.081-8.258,1.533-17.067-5.619-22.674c-3.109-2.437-6.72-3.966-10.168-5.838c-3.444-1.869-6.403-4.26-8.907-7.283
							c-5.016-6.057-7.734-14.065-8.572-21.809c-1.096-10.138,0.359-20.31,1.984-30.308c1.645-10.122,3.315-20.24,4.973-30.36
							c0.84-5.126,1.68-10.252,2.52-15.378c0.275-1.681-0.439-3.399-2.205-3.884c-1.509-0.415-3.607,0.513-3.885,2.205
							c-1.721,10.509-3.443,21.017-5.165,31.526c-1.717,10.476-3.787,20.98-4.615,31.574c-1.351,17.289,2.342,36.986,17.686,47.371
							c6.02,4.075,15.55,5.942,16.709,14.408c0.544,3.976-0.524,8.069-1.695,11.834c-1.46,4.698-3.206,9.317-4.886,13.94
							c-6.618,18.214-13.699,36.512-16.455,55.802c-2.379,16.646-1.17,33.403,4.409,49.315c5.112,14.577,13.29,27.912,23.548,39.431
							c10.37,11.646,22.965,21.441,36.79,28.654c15.006,7.829,31.397,12.38,48.202,14.151c35.97,3.789,72.695-5.702,104.222-22.871
							c3.887-2.117,7.701-4.364,11.446-6.723C1532.449,1045.288,1529.283,1039.821,1525.831,1041.995z" class="colord59622 svgShape"></path><path fill="#1a1a1a" d="M1153.799,1120.846c0,0,20.291,74.542,7.219,84.24c-13.072,9.699-35-93.193-35-93.193
							L1153.799,1120.846z" class="color1a1a1a svgShape"></path><path fill="#e89067" d="M1135.179,1076.289c-7.627-12.204-14.258-13.337-19.396-12.042
							c-6.908,1.741-17.469,3.188-29.08,0.439c-20.282-4.804-37.896,3.202-46.435,10.141c-8.54,6.939-22.802,23.964-22.802,23.964
							s24.366,0.153,26.678,0.055c4.804-1.068,18.008-12.276,27.081-8.006c9.074,4.27-9.607,13.344-13.343,22.417
							s1.067,24.552,10.675,22.951c9.607-1.601,12.81-11.208,18.147-12.81c5.337-1.601,14.411-2.135,30.957-2.135
							c16.546,0,36.206-0.353,36.206-0.353S1142.807,1088.492,1135.179,1076.289z" class="colore89067 svgShape"></path></g><path fill="#ffffff" d="M1401.765,347.65c-2.475-1.238-78.039-9.222-156.592-8.324
					c-78.553,0.898-135.483,2.136-137.958,8.324s-7.536,345.516-7.536,345.516s2.585,61.598,5.061,65.31
					c2.475,3.713,285.159,12.649,290.473-4.814C1400.528,736.199,1401.765,347.65,1401.765,347.65z" opacity=".2" class="colorfff svgShape"></path><path fill="#7198c8" d="M1101.317,763.42c1.233,8.67,312.7,12.382,318.891-4.945c1.836-5.146,2.961-29.334,3.605-63.599
					c0.054-2.667,0.094-5.401,0.147-8.188v-0.161c34.6,0.402,69.254,0.71,103.84,0.241c1.447-0.013,2.76-0.63,3.699-1.581
					c0.938-0.965,1.528-2.278,1.528-3.725c0-2.895-2.332-5.253-5.226-5.293c-34.546-0.469-69.146-0.161-103.693,0.241
					c0.429-32.161,0.523-70.661,0.429-109.83c0-2.653,0-5.32-0.013-7.987v-0.322c17.675,0.121,35.35,0.174,53.026,0.188
					c10.117,0.013,20.248,0.013,30.365,0.027c6.606,0,13.427,0.402,20.127,0.094c2.801-0.12,4.985-2.479,4.985-5.28v-0.161
					c0-2.801-2.184-5.159-4.985-5.28c-6.7-0.308-13.535,0.094-20.127,0.094c-10.117,0.013-20.248,0.013-30.365,0.027
					c-17.689,0.013-35.377,0.067-53.066,0.188c-0.094-29.883-0.295-59.632-0.523-86.795c-0.027-2.881-0.053-5.722-0.08-8.536v-0.764
					c18.653,0.174,37.307,0.241,55.974,0.268c15.946,0.04,31.96,0.389,47.947,0.228c2.894-0.027,5.226-2.399,5.226-5.307v-0.201
					c0-2.908-2.332-5.28-5.226-5.307c-15.987-0.147-32,0.188-47.947,0.228c-18.694,0.027-37.374,0.094-56.068,0.268
					c-0.523-56.135-1.112-97.073-1.112-97.073c-1.233-13.615-304.03-11.136-316.399-2.479
					C1093.893,351.369,1099.428,750.234,1101.317,763.42z M1113.699,350.123c11.136-3.712,228.947-13.615,277.215-1.233
					c2.399,0.617,2.479,400.929-2.465,404.641c-4.958,3.712-274.75,11.136-277.229,2.466
					C1108.741,747.339,1102.55,353.835,1113.699,350.123z" class="color7198c8 svgShape"></path><path fill="#ffffff" d="M1361.903 732.237c0 0-213.068-373.873-221.108-375.213-8.04-1.34-21.441 2.68-22.781 6.7-1.34 4.02-1.34 81.743-1.34 81.743s183.587 225.128 182.247 227.808c-1.34 2.68-60.302-68.342-65.662-67.002-5.36 1.34 87.103 140.705 97.823 140.705 10.72 0 42.882 5.36 38.861-1.34C1365.923 738.938 1361.903 732.237 1361.903 732.237zM1301.601 578.132c0 0-138.025-221.108-131.325-222.448 6.7-1.34 22.781-5.36 26.801 1.34C1201.097 363.724 1306.961 578.132 1301.601 578.132z" opacity=".3" class="colorfff svgShape"></path><path fill="#346a90" d="M1396.637 694.475c1.032.027 2.064.054 3.095.067 7.987.201 16.041.429 24.081.335.054-2.667.094-5.401.147-8.188-8.027-.107-16.08.12-24.054.322-1.099.027-2.184.054-3.27.08C1391.88 687.198 1391.893 694.354 1396.637 694.475zM1397.494 566.312c1.434.013 2.854.04 4.288.054 7.571.107 15.169.201 22.754.214 0-2.653 0-5.32-.013-7.987-7.558.013-15.116.107-22.66.214-1.461.013-2.908.04-4.369.054C1392.697 558.929 1392.71 566.246 1397.494 566.312zM1398.379 460.1c8.268 1.166 16.965 1.38 25.582 1.273-.027-2.881-.053-5.722-.08-8.536-8.59-.121-17.246.094-25.501 1.273C1395.404 454.526 1395.404 459.685 1398.379 460.1zM1497.856 679.409c.015-1.596 2.466-1.599 2.481 0 .012 1.264.219 2.728-.08 3.958-.278 1.147-2.043 1.148-2.322 0C1497.636 682.135 1497.844 680.672 1497.856 679.409zM1497.856 552.104c.015-1.596 2.466-1.599 2.481 0 .012 1.264.219 2.727-.08 3.958-.278 1.147-2.043 1.148-2.322 0C1497.636 554.831 1497.844 553.367 1497.856 552.104zM1497.856 444.901c.015-1.596 2.466-1.599 2.481 0 .012 1.264.219 2.727-.08 3.958-.278 1.147-2.043 1.148-2.322 0C1497.636 447.627 1497.844 446.163 1497.856 444.901z" class="color346a90 svgShape"></path><path fill="#ffffff" d="M1402.208,594.486c0.04,0.502,0.079,1.03,0.132,1.584c1.531,17.519,9.36,60.584,9.36,62.722
				c0,2.64-0.33,17.163-0.33,17.163h24.094c0,0-0.66-7.288-0.568-12.001c0.013-1.281,0.092-2.39,0.251-3.089
				c0.079-0.37,0.185-0.621,0.317-0.753c1.32-1.32,15.842-68.65,14.522-71.29c-1.32-2.64-44.887-2.64-47.527,0
				C1402.037,589.245,1401.984,591.318,1402.208,594.486z" class="colorfff svgShape"></path><path fill="#e3e8ea" d="M1414.064 663.981c6.931.198 13.888.066 20.833-.026.013-1.281.092-2.39.251-3.089-7.023-.079-14.06-.211-21.083-.026C1412.044 660.892 1412.044 663.928 1414.064 663.981zM1412.915 675.955h11.842c-1.558-1.848-3.736-3.301-6.165-3.697C1415.754 671.81 1414.117 673.685 1412.915 675.955zM1402.208 594.486c.04.502.079 1.03.132 1.584 14.403-1.611 29.361-.924 43.685.673 1.241.132.911-1.967-.317-2.139C1431.305 592.572 1416.638 592.532 1402.208 594.486z" class="colore3e8ea svgShape"></path><path fill="#ff8d7d" d="M1447.317,652.625c0,1.648,0.094,3.417,0.228,5.226c0.683,8.683,2.627,18.104,4.141,18.104
				c2.64,0,57.542,0.013,58.962,0c-0.107-0.456,2.439-10.131,3.43-18.211c0.214-1.742,0.375-3.444,0.469-5.012
				c0.214-3.819-0.04-6.807-1.219-7.598c-4.02-2.68-60.302-4.02-64.322-1.34C1447.733,644.638,1447.264,648.189,1447.317,652.625z" class="colorff8d7d svgShape"></path><path fill="#ea6e61" d="M1447.317,652.625c22.312-0.804,44.852-0.241,67.23,0.107c-0.094,1.568-0.255,3.27-0.469,5.012
				c-14.473,0.228-29.018,0.524-43.527,0.492c-1.175,3.15-4.044,5.404-7.523,5.279c-3.245-0.117-6.276-2.328-7.117-5.431
				c-2.792-0.059-5.581-0.131-8.366-0.233C1447.411,656.042,1447.317,654.273,1447.317,652.625z" class="colorea6e61 svgShape"></path><path fill="#f0404c" d="M1452.946,548.247h-43.43c-0.249-1.88-1.813-39.536-2.464-46.498
				c-0.156-1.667-0.273-3.294-0.342-4.794c-0.156-3.653,0.029-6.512,0.889-7.268c2.93-2.564,43.945-3.845,46.875-1.282
				c0.928,0.808,1.269,4.204,1.23,8.447c0,1.577-0.068,3.269-0.166,4.999C1455.101,509.12,1453.963,546.409,1452.946,548.247z" class="colorf0404c svgShape"></path><path fill="#c21e21" d="M1455.658,498.597c-0.026,1.062-0.058,2.136-0.121,3.256c-2.029,0.097-4.062,0.166-6.097,0.222
				c-0.613,2.968-2.821,5.083-5.186,5.195c-2.535,0.12-4.626-2.036-5.482-5.049c-10.574,0.03-21.173-0.253-31.72-0.471
				c-0.102-1.088-0.171-2.127-0.235-3.153H1455.658z" class="colorc21e21 svgShape"></path><path fill="#6d4e4e" d="M1457.783,411.484c0.027,2.774,0.067,5.454,0.107,8.013c0.013,0.965,0.027,1.916,0.04,2.827
				c0.027,1.246,0.054,2.439,0.067,3.591c0.013,0.898,0.04,1.769,0.053,2.6c0.161,7.799,0.322,12.931,0.322,12.931h33.381
				c0,0,0.59-33.582,0.349-59.042c-0.147-14.901-0.563-27.029-1.555-28.021c-2.68-2.68-24.121-4.02-29.481-1.34
				c-1.956,0.978-2.854,12.998-3.189,27.873c-0.094,4.529-0.148,9.313-0.161,14.138
				C1457.689,400.602,1457.729,406.19,1457.783,411.484z" class="color6d4e4e svgShape"></path><path fill="#4b3333" d="M1458.293 440.09c11.083-.125 22.209-.163 33.29.121 1.542.039 1.545 2.358 0 2.397-11.081.283-22.206.246-33.29.12C1456.596 442.71 1456.593 440.11 1458.293 440.09zM1457.877 380.917c11.431-.174 22.834.295 34.225 1.488-.147-14.901-.563-27.029-1.555-28.021-2.68-2.68-24.121-4.02-29.481-1.34C1459.11 354.022 1458.212 366.043 1457.877 380.917z" class="color4b3333 svgShape"></path><path fill="#e4d4c7" d="M1457.783,411.484c2.827,1.152,6.271,1.822,9.983,1.822c9.622,0,17.421-4.503,17.421-10.05
				c0-5.548-7.799-10.05-17.421-10.05c-3.739,0-7.209,0.684-10.05,1.849C1457.689,400.602,1457.729,406.19,1457.783,411.484z" class="colore4d4c7 svgShape"></path><path fill="#4b3333" d="M1457.89 419.497c.013.965.027 1.916.04 2.827 2.104-.027 4.221-.107 6.298-.107 4.931-.013 9.849-.027 14.767-.067 1.595-.013 1.595-2.466 0-2.479-4.918-.04-9.836-.054-14.767-.067C1462.152 419.604 1460.007 419.524 1457.89 419.497zM1468.911 425.676c2.69-.022 5.379.028 8.069.073 1.563.026 1.565 2.402 0 2.429-2.689.046-5.379.095-8.069.073C1467.254 428.238 1467.251 425.689 1468.911 425.676zM1457.998 425.916c.013.898.04 1.769.053 2.6 1.849 0 3.712-.027 5.561-.054 1.608-.027 1.595-2.466 0-2.492C1461.736 425.943 1459.86 425.916 1457.998 425.916z" class="color4b3333 svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#ecaf32" d="M683.828,1757.493c0,0,15.825-2.93,21.099,0.586c5.275,3.516,1.758,8.205,8.792,12.308
			c7.033,4.103,34.58,21.099,46.888,29.891c12.308,8.792,5.275,16.997,5.275,16.997s2.344,6.447,0.586,11.722
			c-1.758,5.275-193.411,5.275-208.65,3.516c0,0-3.987-1.304-4.916-9.668c-0.929-8.364,1.394-17.424,3.717-17.889
			c2.323-0.464,36.475-0.232,41.818,0c5.343,0.232,48.323-44.141,55.293-46.232C660.699,1756.633,683.828,1757.493,683.828,1757.493
			z" class="colorecaf32 svgShape"></path><path fill="#d59622" d="M556.619,1804.956c2.323-0.465,36.475-0.232,41.818,0c1.241,0.054,4.527-2.316,8.906-5.986
			c-0.004,0.583-0.017,1.166-0.018,1.749c-0.026,10.62,0.565,21.229,1.381,31.815c0.025,0.33,0.052,0.659,0.078,0.989
			c-26.197-0.118-46.423-0.486-50.966-1.01c0,0-3.987-1.304-4.916-9.668C551.972,1814.481,554.295,1805.421,556.619,1804.956z" class="colord59622 svgShape"></path><path fill="#e89067" d="M652.765,1663.717c0,0-4.103,49.232-4.103,59.782c0,10.55,35.166,33.993,35.166,33.993
			s-18.755,3.517-34.58,17.583s-24.03,34.58-24.03,34.58s-59.782,2.344-63.884-2.344c-4.103-4.689,10.55-69.745,12.308-77.365
			c1.758-7.619,6.447-75.606,10.55-94.361C588.294,1616.83,652.765,1663.717,652.765,1663.717z" class="colore89067 svgShape"></path><path fill="#d59622" d="M652.245 1804.388c2.16-10.356 10.522-17.987 18.471-24.283 8.478-6.715 17.988-12.195 28.883-13.512 2.014-.243 1.996 2.917 0 3.158-10.191 1.232-19.299 6.688-27.172 13.003-7.34 5.887-15.132 12.861-17.138 22.474C654.875 1807.215 651.831 1806.374 652.245 1804.388zM632.463 1809.682c35.293 3.899 70.845 4.219 106.312 3.715 9.664-.137 19.328-.335 28.991-.534-.422 2.696-1.885 4.41-1.885 4.41s.049.135.121.362c-34.542.71-69.129 1.35-103.64-.7-9.986-.593-19.957-1.419-29.899-2.517C629.466 1814.088 629.432 1809.348 632.463 1809.682z" class="colord59622 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#ecaf32" d="M531.155,1764.844c0,0,9.731-3.518,15.006-0.001c5.275,3.516,7.892,13.119,14.925,17.221
			c7.033,4.103,20.413,12.736,32.721,21.527c12.308,8.792,5.741,21.035,5.741,21.035s2.344,6.447,0.586,11.722
			c-1.758,5.275-179.75,5.275-194.989,3.517c0,0-3.987-1.304-4.916-9.668c-0.929-8.364,1.394-17.424,3.717-17.889
			c2.323-0.465,36.475-0.232,41.818,0c5.343,0.232,48.323-44.141,55.293-46.232C508.027,1763.984,531.155,1764.844,531.155,1764.844
			z" class="colorecaf32 svgShape"></path><path fill="#e89067" d="M500.092,1671.069c0,0-4.103,49.232-4.103,59.782s35.166,33.994,35.166,33.994
			s-18.755,3.516-34.58,17.583c-15.825,14.066-24.03,34.579-24.03,34.579s-59.782,2.344-63.884-2.344
			c-4.103-4.689,10.55-69.745,12.308-77.365c1.758-7.619,6.447-75.606,10.55-94.361
			C435.622,1624.182,500.092,1671.069,500.092,1671.069z" class="colore89067 svgShape"></path><path fill="#d59622" d="M500.829 1803.695c10.939-13.196 25.476-24.434 43.22-25.337 2.031-.103 2.026 3.055 0 3.158-16.891.86-30.616 11.901-40.987 24.412C501.764 1807.494 499.541 1805.249 500.829 1803.695zM476.783 1816.932c32.783 3.527 65.793 4.869 98.753 3.969 8.519-.233 17.031-.637 25.536-1.164-.425 2.628-1.316 4.478-1.492 4.823-31.592 1.89-63.297 1.781-94.872-.413-9.324-.648-18.633-1.479-27.926-2.479C473.784 1821.347 473.751 1816.606 476.783 1816.932z" class="colord59622 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#afa873" d="M547.044,1248.631c0,0-15.44,89.835-22.459,161.422c-7.019,71.587-5.811,293.211-21.252,304.44
			c-15.44,11.229-136.156,0-147.386-8.422c-11.229-8.422,24.059-527.624,36.692-614.652c12.633-87.028,53.34-199.321,58.954-199.321
			c5.615,0,223.184,119.312,223.184,119.312s39.303,331.267,37.899,370.57c-1.404,39.303-26.866,329.706-32.481,338.128
			c-5.615,8.422-145.982,1.404-147.385-7.018c-1.404-8.422,32.481-318.477,33.885-340.936
			C568.099,1349.696,547.044,1248.631,547.044,1248.631z" class="colorafa873 svgShape"></path><path fill="#93884f" d="M565.728 1363.69c1.912 7.888 4.768 15.486 8.568 22.658 1.426 2.692-2.661 5.088-4.09 2.391-3.984-7.52-7.041-15.518-9.045-23.79C560.443 1361.988 565.01 1360.724 565.728 1363.69zM354.215 1648.202c7.377 1.577 14.773 3.061 22.195 4.421 28.984 5.313 58.38 8.76 87.878 8.741 16.416-.011 32.838-1.102 49.078-3.52-.12 1.625-.242 3.224-.366 4.797-28.756 4.131-57.895 4.307-86.806 1.68-24.249-2.204-48.286-6.265-72.096-11.325C354.133 1651.429 354.173 1649.827 354.215 1648.202zM537.483 1657.714c10.514 1.417 21.062 2.587 31.633 3.483.901-11.771 1.803-23.542 2.705-35.312 2.086-27.236 4.172-54.472 6.258-81.708 2.086-27.236 4.166-54.473 6.259-81.708.469-6.117.94-12.33 2.726-18.232 1.648-5.444 5.533-11.157 1.722-16.527-2.365-3.33-5.091-6.827-2.678-10.96 1.84-3.152 5.424-4.703 8.041-7.077 6.924-6.281-4.381-12.56-4.291-19.326.065-4.888 4.877-5.85 8.568-7.139 3.681-1.285 4.53-5.318 2.871-8.634-.728-1.454-2.008-2.695-3.678-2.907-1.988-.252-2.014-3.413 0-3.158 7.15.907 10.473 11.226 4.874 16.044-1.754 1.509-4.075 1.889-6.211 2.577-2.008.647-3.654 1.951-3.146 4.201.836 3.695 4.175 6.618 5.643 10.087 1.513 3.579.939 7.121-1.798 9.916-2.435 2.488-6.595 3.997-8.234 7.171-1.104 2.138.166 4.122 1.444 5.848 1.463 1.975 2.927 3.853 3.357 6.341.995 5.755-2.782 11.382-4.095 16.811-1.584 6.553-1.835 13.372-2.348 20.069-.531 6.94-1.063 13.88-1.594 20.82-1.063 13.88-2.127 27.76-3.19 41.64l-6.409 83.672-3.657 47.739c35.204 2.813 70.639 2.755 105.83-.189 3.446-.288 6.889-.605 10.33-.948-.172 1.608-.343 3.19-.513 4.75-38.325 3.777-76.959 4.207-115.368 1.159-.214-.017-.426-.039-.639-.056-.797 10.406-1.594 20.812-2.391 31.219-.26 3.404-.522 6.809-.783 10.214-.154 2.013-3.313 2.03-3.158 0 1.065-13.902 2.13-27.805 3.195-41.707-10.605-.906-21.183-2.081-31.732-3.494C537.175 1660.86 537.328 1659.297 537.483 1657.714zM569.932 1193.671c7.156 40.65 14.311 81.301 21.468 121.951 2.005 11.392 4.01 22.785 6.016 34.177.349 1.987-2.693 2.84-3.045.839-7.156-40.65-14.311-81.301-21.467-121.951-2.006-11.392-4.011-22.785-6.017-34.177C566.538 1192.523 569.58 1191.67 569.932 1193.671z" class="color93884f svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#eff1f1" d="M1247.932,1046.503c-0.99,6.929-3.551,13.524-5.276,20.307
						c-2.548,10.015-3.263,20.391-3.969,30.7c8.021-3.733,17.417-4.418,25.895-1.887c1.225-8.944-3.687-17.625-3.975-26.647
						c-0.076-2.39,0.174-4.787-0.034-7.169c-0.156-1.784-0.566-3.589-0.211-5.343c0.377-1.869,1.591-3.493,1.933-5.369
						c0.284-1.556-0.055-3.148-0.279-4.715c-0.998-6.991,0.305-14.083,1.605-21.024c-0.011,0.061-8.189-1.815-8.978-1.824
						c-2.627-0.028-3.28,0.146-4.476,2.529C1247.344,1031.688,1248.808,1040.374,1247.932,1046.503z" class="coloreff1f1 svgShape"></path><path fill="#a0bbd5" d="M1398.851,999.072c-0.878,1.307-2.4,1.999-3.843,2.633
						c-10.046,4.438-20.092,8.866-30.149,13.304c-1.327,0.585-2.994,1.209-3.999,2.312c-0.332,0.361-0.312,6.008-0.117,13.977
						c0.02,1.112,0.049,2.263,0.078,3.463c0.546,20.824,1.902,52.923,1.365,53.46c-0.975,0.975-30.236,1.951-31.212,0.975
						c-0.975-0.975-0.488-21.946-1.463-22.921c-0.975-0.975-49.256-46.33-51.207-45.355c-1.951,0.975-3.414,10.241-5.365,11.217
						c-1.951,0.975-29.749-4.389-31.212-5.852c0,0-0.975-20.483,15.118-29.749c11.344-6.525,25.36,5.852,27.31,7.803
						c1.951,1.951,45.842,45.842,46.818,44.867c0.498-0.498,0.429-6.974,0.293-13.928c-0.029-1.161-0.049-2.341-0.068-3.511
						c-0.146-6.828-0.273-13.246,0.088-14.084c0.897-2.078,2.692-2.341,4.721-3.121c4.399-1.697,8.847-3.258,13.324-4.74
						c8.954-2.955,18.015-5.599,27.037-8.388c4.126-1.288,8.222-2.721,12.426-3.736c1.687-0.41,9.256-2.35,10.3,0.322
						C1399.241,998.37,1399.066,998.76,1398.851,999.072z" class="colora0bbd5 svgShape"></path><path fill="#ffffff" d="M1251.47 1005.979c-2.276 4.113-3.505 8.516-3.868 13.195-.171 2.213 3.264 2.195 3.444 0 .333-4.041 1.493-7.888 3.318-11.503C1255.331 1005.758 1252.522 1004.077 1251.47 1005.979zM1356.644 1040.702c-.004-2.108-3.273-2.112-3.277 0-.013 6.866-.056 13.732.008 20.597.02 2.098 3.242 2.102 3.261 0C1356.699 1054.434 1356.656 1047.567 1356.644 1040.702z" class="colorfff svgShape"></path><path fill="#8ea7bb" d="M1334.017 1048.743c-1.443-1.639-3.763.741-2.382 2.381 2.617 3.109 5.271 6.238 7.351 9.745 1.029 1.736 2.718 4.569 2.55 6.509-.218 2.515-2.437 4.02-3.814 5.842-.741.981.479 2.243 1.514 1.97C1353.388 1071.458 1338.66 1054.015 1334.017 1048.743zM1360.822 1034.761c-9.637 1.473-19.868 1.112-29.554.517-.029-1.161-.049-2.341-.068-3.511 9.871.224 19.693-.527 29.544-.468C1360.763 1032.41 1360.792 1033.561 1360.822 1034.761z" class="color8ea7bb svgShape"></path><path fill="#ffffff" d="M1103.714,1098.95c0,0-3.901-14.631-0.975-16.581c2.926-1.951,304.01-1.61,307.242,0.975
			c4.877,3.901,0.975,17.557,0.975,17.557L1103.714,1098.95z" class="colorfff svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#5b71cb" d="M1532.3,1324.681l-533.274-0.446c0,0-2.077-222.514,1.697-225.527
					c260.542,0.218,262.051,0.193,438.988,1.34c79.078,0.511,89.562,1.169,90.511,2.12
					C1533.238,1105.187,1532.3,1324.681,1532.3,1324.681z" class="color5b71cb svgShape"></path><path fill="#343776" d="M1286.28,1107.243c-0.055,1.257-0.104,2.515-0.167,3.771l141.521,0.118l-0.17,202.901
					l-142.724-0.119c0.042,1.257,0.099,2.514,0.167,3.771l146.326,0.122l0.176-210.443L1286.28,1107.243z" class="color343776 svgShape"></path><path fill="#343776" d="M1048.055,1107.044l-0.003,3.771l96.729,0.081l-0.169,202.901l-96.729-0.081l-0.003,3.771
					l241.55,0.202l0.176-210.443L1048.055,1107.044z M1285.661,1313.915l-137.279-0.115l0.17-202.901l137.278,0.115
					L1285.661,1313.915z" class="color343776 svgShape"></path><path fill="#343776" d="M1255.486,1317.661l0.003-3.771l-107.289-0.09l0.169-202.901l107.289,0.09l0.003-3.771
					l-249.093-0.208l-0.176,210.443L1255.486,1317.661z M1010.338,1110.784l134.261,0.112l-0.17,202.901l-134.261-0.112
					L1010.338,1110.784z" class="color343776 svgShape"></path><path fill="#3d54a4" d="M1532.3,1324.681l-92.776-0.078l0.188-224.556c79.078,0.511,89.562,1.169,90.511,2.12
				C1533.238,1105.187,1532.3,1324.681,1532.3,1324.681z" class="color3d54a4 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#814915" d="M532.536,629.851c12.601,17.017,29.165,32.36,50.153,37.782c5.239,1.354,10.542,2.024,15.849,2.176
			c4.046,6.909,9.793,12.646,16.802,16.843c20.645,12.363,47.338,11.153,69.725,4.752c22.508-6.435,43.431-19.322,58.412-37.418
			c3.754-4.535,6.782-9.46,10.106-14.296c1.913-2.785,4.296-5.018,7.597-5.983c2.894-0.845,5.962-0.778,8.934-0.469
			c6.288,0.652,12.41,2.256,18.735,2.712c6.19,0.446,12.456,0.195,18.545-1.05c11.234-2.297,21.46-8.35,27.363-18.376
			c2.964-5.035,4.711-10.806,4.757-16.551c9.625-2.539,18.86-6.506,27.346-11.712c16.487-10.114,30.271-24.726,39.271-41.857
			c4.429-8.429,7.979-17.66,9.592-27.071c1.428-8.336,1.174-18.092-4.984-24.462c4.177-4.232,6.539-9.761,7.347-15.664
			c1.688-12.319-2.092-25.833-7.689-36.748c-3.058-5.964-7.466-11.515-13.632-14.445c-3.005-1.428-6.255-2.21-9.49-2.211
			c-7.532-9.701-19.472-15.222-31.66-16.745c-6.503-0.813-13.16-0.511-19.556,0.931c-6.494,1.464-13.369,4.371-17.024,10.251
			c-1.664,2.678-2.35,5.925-4.246,8.466c-0.798,1.069-1.654,1.539-2.536,1.64c-0.042-0.03-0.06-0.07-0.106-0.099
			c-2.854-1.757-5.904-3.115-9.058-4.107c-4.808-2.083-10.17-2.729-15.379-2.087c-0.911,0.113-1.812,0.265-2.706,0.444
			c-8.792,1.044-17.265,4.712-23.805,10.926c-13.849,13.155-17.313,33.129-17.296,51.404c0.005,5.342,4.414,26.39,4.663,31.724
			c0.109,2.325,0.245,5.139-1.843,6.688c-1.467,1.089-3.479,1.131-5.223,0.97c-4.555-0.421-9.084-2.462-13.362-3.961
			c-4.975-1.744-9.925-3.562-14.901-5.303c-14.427-5.049-35.082-20.085-49.187-25.279c-13.839-4.032-28.841-5.061-42.822-2.422
			c-8.888,1.677-17.5,5.113-24.635,10.741c-7.546,5.953-12.838,14.217-15.802,23.312c-0.008,0.026-0.014,0.053-0.023,0.079
			c-1.37,0.022-2.77-0.101-4.185-0.37c-4.959-0.943-9.896-2.981-15.014-2.811c-4.128,0.137-7.871,2.033-10.192,5.479
			c-2.06,3.059-2.729,6.831-3.181,10.419c-0.786,6.238-0.028,16.819-7.595,19.139c-2.677,0.821-5.561,0.654-8.271,1.374
			c-2.152,0.571-4.231,1.499-6.106,2.697c-3.897,2.49-7.028,6.094-9.23,10.141C505.772,590.062,520.307,613.335,532.536,629.851z" class="color814915 svgShape"></path><path fill="#ffffff" d="M684.38,495.146c7.341,8.876,16.678,15.793,26.486,21.718c7.066,4.269,14.682,8.532,22.812,10.004
			c-0.43,0.019-0.853,0.032-1.262,0.034c-3.618,0.02-7.186-0.709-10.574-1.957c-6.683-2.462-12.37-7.01-17.427-11.915
			c-1.46-1.416-3.694,0.815-2.233,2.233c5.794,5.62,12.38,10.678,20.15,13.187c6.308,2.036,15.401,2.863,21.277-1.142
			c-0.011,1.704,0.327,3.829,1.247,6.422c3.114,8.775,15.569,22.646,19.532,22.08c3.963-0.566,13.305-5.945,2.265-13.305
			c-10.323-6.882-17.673-17.473-18.585-18.819c0.225-6.631-0.29-13.437-1.996-19.844c-1.326-4.979-3.804-10.597-8.398-13.384
			c-2.055-1.247-4.742-1.863-6.935-0.598c-0.437,0.252-0.806,0.565-1.14,0.906c-4.054-4.393-8.885-8.037-14.497-10.237
			c-2.983-1.169-7.335-2.446-9.407,0.943c-1.752,2.866-0.495,6.564,0.689,9.379c3.026,7.195,8.752,12.79,14.639,17.718
			c6.383,5.343,12.953,10.472,19.471,15.654c0.025,0.026,0.051,0.05,0.076,0.075c-10.552,0.546-20.59-5.533-29.264-10.864
			c-9.171-5.636-17.802-12.188-24.693-20.521C685.316,491.345,683.094,493.591,684.38,495.146z M732.215,512.985
			c0.218,0.411,0.477,0.797,0.707,1.201c-2.999-2.397-5.989-4.805-8.947-7.252c-5.229-4.324-10.432-9.059-13.658-15.124
			c-1.015-1.91-3.761-6.958-1.682-8.949c1.299-1.244,4.227,0.16,5.629,0.713c1.569,0.619,3.081,1.396,4.527,2.266
			c3.542,2.131,6.551,4.787,9.176,7.78c-0.25,0.809-0.402,1.657-0.473,2.491C727.002,501.861,729.574,508,732.215,512.985z
			 M742.84,522.08c-0.048-0.038-0.096-0.076-0.143-0.114c-2.997-3.082-5.578-6.525-7.624-10.331
			c-2.247-4.181-4.381-9.179-4.47-13.991c-0.005-0.231-0.002-0.482,0.008-0.741C736.098,504.392,739.669,513.459,742.84,522.08z
			 M732.849,494.633c-0.377-0.498-0.776-0.979-1.171-1.464c0.489-0.589,1.183-0.941,2.177-0.83c2.26,0.254,4.111,2.198,5.393,3.929
			c2.714,3.667,3.925,8.228,4.695,12.658c0.554,3.188,0.845,6.411,0.952,9.641C741.759,510.181,738.279,501.807,732.849,494.633z" class="colorfff svgShape"></path><path fill="#e89067" d="M779.963,531.484c0,0-11.032,12.035-33.097,16.047c-22.065,4.012-43.628,8.024-43.628,8.024
				s22.566,72.714,26.578,83.746c4.012,11.033,78.485-29.134,78.485-29.134s-9.783-7.975-10.786-20.01
				c-1.003-12.035,28.584-32.094,28.584-32.094L779.963,531.484z" class="colore89067 svgShape"></path><path fill="#1a1a1a" d="M797.515,590.156c0.193,2.317,0.715,4.479,1.427,6.468c-5.648-1.168-11.006-4.213-15.341-7.806
				c-5.78-4.791-10.769-11.229-12.693-18.587c-1.626-6.223-0.389-12.927,1.21-19.026c1.788-6.819,4.429-13.448,7.782-19.656
				c0.019-0.021,0.062-0.065,0.062-0.065l46.136,26.578C826.099,558.062,796.512,578.121,797.515,590.156z" class="color1a1a1a svgShape"></path><path fill="#ecaf32" d="M1000.817,1065.74c0,0-13.946,81.666-30.495,118.789c-16.549,37.123-28.013,27.304-34.75,17.021
			c-2.643-4.034-5.96-13.862-13.12-15.248c-21.985-4.255-32.108-21.051-31.168-24.811c1.342-5.367-36.676-36.229-40.254-49.646
			c-3.578-13.418-5.367-12.971-17.443-26.389c-12.076-13.418-21.469-25.047-25.941-34.887c-4.473-9.84-17.891-25.942-17.891-25.942
			s-15.654,22.811-38.018,34.887c-22.363,12.076-49.646,17.891-54.119,20.127c-4.473,2.236,5.367,86.323,6.262,97.057
			c0.895,10.734,8.956,88.103,8.956,88.103s8.062,5.375-34.399,8.062c-6.344,0.402-12.256,0.599-17.742,0.62
			c-3.388,0.013-7.412-48.608-10.476-48.724c-3.409-0.129-5.82,48.231-8.831,47.959c-19.227-1.737-30.375-6.208-33.899-11.142
			c-5.375-7.525-15.587-1.612-22.574,6.45c-6.987,8.062-74.71-3.762-92.984-12.362c-18.274-8.6-19.887-18.812-18.812-24.187
			c1.075-5.375-2.15-3.762-16.124-1.612c-13.974,2.15-59.123-30.636-70.41-45.686c-11.287-15.049,0-26.337-5.912-33.324
			c-5.912-6.987-4.3,4.3-16.124-2.688c-11.825-6.987-30.636-45.148-36.011-55.898c-5.375-10.75,54.823-115.827,98.359-181.937
			s68.529-92.715,87.072-127.383c18.543-34.667,10.266-121.633,14.297-148.238c4.031-26.605,23.111-44.037,50.247-58.319
			c28.971-15.248,126.733-22.344,126.733-22.344s35.98,72.77,40.033,82.904c14.462-5.875,56.268-29.49,63.024-26.787
			c6.756,2.702,40.535,54.722,42.562,69.585c2.027,14.863,16.214,154.033,18.241,160.789c2.027,6.756,18.241,10.134,12.161,19.592
			c-6.08,9.458-0.676,15.538,6.08,20.267c6.756,4.729,10.809,5.405,7.432,15.539c-3.378,10.134,4.054,26.348,4.054,26.348
			s65.222,108.575,70.627,115.331c5.405,6.756,10.443,3.572,12.47,8.977c2.027,5.405,1.47,8.66,5.524,9.336
			C991.503,1056.605,1002.465,1056.11,1000.817,1065.74z" class="colorecaf32 svgShape"></path><path fill="#1a1a1a" d="M744.111,717.993c0,0-7.43,117.471-18.784,116.438c-8.868-0.806-14.175-49.319-16.317-91.023
			c-0.753-14.65-1.112-25.885-1.336-29.168C706.812,701.611,744.111,717.993,744.111,717.993z" class="color1a1a1a svgShape"></path><path fill="#d9ecf2" d="M523.51,637.092c1.938,25.555,6.879,50.755,13.085,75.59c3.101,12.409,6.514,24.737,10.04,37.031
			c1.779,6.204,3.587,12.4,5.398,18.595c1.659,5.677,3.188,11.495,5.997,16.737c2.674,4.991,6.683,8.871,10.298,13.157
			c3.229,3.828,5.613,7.901,7.641,12.458c1.678,3.771,3.232,8.005,6.062,11.096c3.641,3.979,8.49,3.231,13.36,4.256
			c5.324,1.121,8.979,5.087,12.36,9.053c3.189,3.74,6.678,6.953,11.035,9.291c4.091,2.194,8.803,3.551,13.474,3.07
			c4.986-0.513,8.585-3.945,13.085-5.751c2.272-0.911,4.795-1.258,7.113-0.316c2.514,1.022,3.781,3.109,4.981,5.407
			c2.132,4.084,7.007,3.649,11.003,3.21c12.67-1.391,25.27-3.878,37.598-7.094c3.044-0.794,6.072-1.642,9.088-2.534
			c3.906-1.155,5.574,4.938,1.679,6.09c-12.55,3.71-25.341,6.572-38.284,8.513c-5.571,0.836-11.521,2.131-17.163,1.332
			c-2.424-0.343-4.713-1.17-6.613-2.747c-0.946-0.784-1.734-1.77-2.354-2.829c-0.557-0.951-0.908-2.195-1.65-3.019
			c-1.314-1.461-3.767,0.077-5.099,0.809c-2.398,1.316-4.618,2.848-7.177,3.855c-4.695,1.847-9.967,1.819-14.819,0.622
			c-5.098-1.258-9.789-3.831-13.895-7.058c-4.077-3.204-6.892-7.491-10.68-10.965c-1.913-1.755-4.065-2.741-6.648-3.063
			c-2.914-0.363-5.871-0.363-8.648-1.431c-4.334-1.666-7.417-5.112-9.667-9.076c-2.239-3.943-3.722-8.257-5.84-12.262
			c-2.582-4.884-6.496-8.687-10.04-12.855c-3.957-4.656-6.809-9.73-8.906-15.466c-2.162-5.915-3.748-12.056-5.508-18.1
			c-3.717-12.766-7.38-25.55-10.762-38.41c-6.688-25.428-12.26-51.205-14.981-77.386c-0.34-3.267-0.63-6.538-0.878-9.813
			C516.887,633.039,523.204,633.058,523.51,637.092z" class="colord9ecf2 svgShape"></path><path fill="#d59622" d="M585.186 674.354c19.886-3.143 39.771-6.285 59.657-9.428-.285-9.929-1.615-19.756-3.997-29.403-.974-3.945 5.114-5.629 6.09-1.679 2.432 9.85 3.828 19.948 4.186 30.088 2.239-.365 4.577-.891 6.79-.131 1.808.621 2.984 2.386 4.669 2.983 2.135.757 5.249-1.271 7.303-2.375 3.027-1.628 6.184-3.302 9.692-3.461 1.868-.085 3.599.447 5.278 1.21 1.972.896 3.039 1.118 4.855-.264 1.873-1.426 3.27-3.432 4.881-5.126 1.792-1.884 3.792-3.602 5.955-5.049 4.362-2.918 9.343-4.276 14.543-3.341 1.68.302 2.628 2.347 2.206 3.884-.486 1.769-2.2 2.508-3.885 2.206-4.033-.725-8.001 1.284-11.081 3.726-3.455 2.739-5.823 6.606-9.431 9.153-1.651 1.166-3.628 1.969-5.675 1.973-2.369.004-3.984-1.342-6.155-1.91-2.6-.68-5.364 1.041-7.572 2.224-2.942 1.577-6.005 3.371-9.417 3.581-1.622.1-3.232-.228-4.687-.951-1.737-.863-2.756-2.702-4.821-2.51-5.046.469-10.119 1.59-15.127 2.381-5.413.855-10.825 1.71-16.237 2.566l-36.339 5.742c-1.682.266-3.397-.432-3.884-2.206C582.568 676.737 583.492 674.621 585.186 674.354zM887.296 1154.771c13.216-28.017 28.721-54.942 46.409-80.397 7.108-10.229 14.57-20.209 22.331-29.952 1.064-1.335 3.355-1.11 4.465 0 1.319 1.319 1.066 3.127 0 4.466-27.136 34.062-50.195 71.386-68.618 110.846-.2.429-.391.862-.59 1.292C891.178 1159.745 889.679 1157.564 887.296 1154.771zM925.582 1115.236c12.86-22.042 28.273-42.548 45.861-61.038 1.404-1.475 3.634.76 2.233 2.233-17.411 18.303-32.637 38.58-45.367 60.399C927.285 1118.584 924.555 1116.996 925.582 1115.236zM926.078 1160.662c7.41-22.623 17.384-44.398 29.751-64.742 3.565-5.865 7.333-11.605 11.277-17.222 1.16-1.651 3.899-.074 2.727 1.594-17.484 24.897-31.239 52.296-40.71 81.209C928.493 1163.424 925.443 1162.601 926.078 1160.662zM652.937 724.436c2.03-9.441 4.221-18.846 6.419-28.249.463-1.978 3.508-1.141 3.045.84-7.671 32.811-15.401 65.987-16.074 99.833-.187 9.454.208 18.912 1.27 28.309.228 2.016-2.932 2-3.158 0C640.622 791.375 645.837 757.447 652.937 724.436zM681.077 677.485c.668-1.905 3.72-1.085 3.044.839-8.368 23.851-13.377 48.785-14.813 74.022-.115 2.02-3.273 2.034-3.158 0C667.602 726.835 672.615 701.598 681.077 677.485zM600.123 568.885c1.271-.323 2.568-.641 3.889-.953 10.425 8.324 20.321 17.312 29.584 26.918 7.285 7.555 14.168 15.49 20.639 23.752 1.239 1.582-.981 3.832-2.233 2.233C636.864 601.506 619.403 584.048 600.123 568.885zM844.962 664.306c.553 1.113 1.08 2.201 1.57 3.253-8.478 12.386-17.458 24.429-26.959 36.055-5.854 7.163-11.899 14.167-18.118 21.015-1.369 1.508-3.597-.731-2.233-2.233C815.81 704.13 831.097 684.707 844.962 664.306zM691.789 555.186c12.073 24.336 23.966 48.762 35.634 73.296 5.115 10.756 10.19 21.532 15.227 32.325.854 1.83-1.867 3.435-2.727 1.594-16.727-35.841-33.898-71.475-51.487-106.901C689.603 555.389 690.722 555.284 691.789 555.186zM374.991 1136.605c12.297-23.913 24.455-47.899 36.468-71.956 12.071-24.174 23.998-48.42 35.778-72.737 6.627-13.678 13.206-27.379 19.742-41.101.873-1.834 3.596-.233 2.726 1.594-11.562 24.278-23.266 48.487-35.115 72.626-11.906 24.255-23.958 48.439-36.154 72.55-6.86 13.562-13.767 27.101-20.719 40.618C376.788 1140.007 374.062 1138.411 374.991 1136.605zM389.431 1141.017c14.576-27.377 29.152-54.755 43.727-82.133.956-1.794 3.683-.201 2.727 1.594-14.576 27.377-29.151 54.755-43.727 82.133C391.201 1144.405 388.475 1142.812 389.431 1141.017zM472.107 1217.572c15.152-39.737 30.303-79.474 45.455-119.212l12.907-33.85c.717-1.88 3.77-1.064 3.045.839-15.152 39.737-30.303 79.474-45.455 119.212-4.302 11.283-8.604 22.567-12.907 33.85C474.435 1220.292 471.381 1219.476 472.107 1217.572zM594.974 1197.014c.557-1.951 3.605-1.121 3.044.839-3.922 13.729-5.393 27.991-4.38 42.233.145 2.028-3.014 2.019-3.158 0C589.449 1225.584 590.98 1210.991 594.974 1197.014zM671.472 1038.388c29.071-29.853 47.883-69.25 53.385-110.522 1.374-10.303 1.904-20.726 1.577-31.115-.34-10.78-2.197-21.654-.737-32.42.681-5.019 2.166-9.937 4.843-14.267 2.945-4.763 7.075-8.622 10.505-13.015 6.431-8.237 10.924-17.943 13.261-28.115 2.845-12.38 1.872-24.584-1.053-36.839-3.006-12.588-7.129-25.23-5.961-38.341.179-2.008 3.338-2.027 3.158 0-1.079 12.106 2.463 23.781 5.335 35.398 2.66 10.758 4.314 21.525 2.957 32.606-1.259 10.284-4.565 20.287-9.804 29.236-2.726 4.657-6.012 8.865-9.566 12.911-3.869 4.406-7.403 8.831-9.179 14.513-3.283 10.512-1.541 21.847-.871 32.607.647 10.379.42 20.808-.641 31.152-2.13 20.784-7.551 41.144-15.93 60.278-9.423 21.517-22.655 41.333-39.047 58.166C672.285 1042.079 670.053 1039.845 671.472 1038.388zM648.288 1092.816c.217-1.999 3.377-2.021 3.158 0-3.544 32.611-3.242 65.575.898 98.115.256 2.01-2.904 1.992-3.158 0C645.046 1158.39 644.744 1125.427 648.288 1092.816zM755.516 744.517c.207 1.066.716 2.135 1.588 2.808 1.125.869 2.576.952 3.83.293 2.609-1.37 2.523-4.62 1.854-7.085-.036-1.155-.498-2.237-1.468-2.958-.321-.238-.689-.376-1.073-.463-1.274-.54-2.852-.44-3.79.689-.836 1.006-1.042 2.339-1.055 3.622C755.27 742.464 755.327 743.542 755.516 744.517z" class="colord59622 svgShape"></path><path fill="#d59622" d="M733.226 862.598c.532-1.375 1.482-2.768 3.003-3.138 1.626-.396 3.143.607 3.84 2.042.32.66.508 1.376.595 2.105.129.158.224.347.267.564.554 2.762-.554 5.557-2.815 7.229-1.314.971-3.239 1.548-4.538.228-1.076-1.093-1.166-3.012-1.167-4.45C732.41 865.636 732.668 864.039 733.226 862.598zM692.299 1029.907c.269-.768.615-1.522 1.061-2.204.291-.447.625-.864.98-1.264.156-.223.316-.445.486-.658.907-1.134 2.099-2.081 3.404-2.716 1.133-.552 2.26.133 2.376 1.363.293 3.131-1.071 6.479-3.482 8.503-.764.642-1.535 1.123-2.546 1.232-1.112.12-2.175-.535-2.529-1.604C691.761 1031.698 692.008 1030.738 692.299 1029.907zM653.884 1099.915c.455-1.633 1.381-3.178 2.676-4.281.651-.555 1.882-.659 2.39.178.301.197.546.483.657.866.214.743.355 1.511.433 2.284.275 1.189.42 2.406.389 3.643-.027 1.082-.095 2.259-.571 3.247-.409.847-1.278 1.336-2.159 1.332-.876.486-1.979.302-2.73-.418-.625-.599-.954-1.445-1.159-2.27C653.436 1103.001 653.47 1101.398 653.884 1099.915zM655.82 1197.216c.712-1.655 2.304-3.796 4.352-2.787.769.379 1.329 1.23 1.729 1.966.378.696.675 1.46.839 2.236.33 1.562.287 3.25-.267 4.758-.563 1.529-1.759 3.423-3.549 3.349-.023.017-.043.037-.066.054-.743.545-1.692.055-2.16-.566C654.766 1203.662 654.577 1200.109 655.82 1197.216z" class="colord59622 svgShape"></path><path fill="#e89067" d="M764.106,510.318c4.777-11.712,18.542-10.612,23.269-2.035c3.731,6.677,9.253,2.73,10.839-1.052
						c1.643-3.916,2.567-8.654,6.222-10.815c3.253-1.924,14.008-2.531,38.759-19.454c5.741-3.925,24.643-13.428,37.66-5.647
						c1.353,10.431,4.985,20.634,12.728,27.587c0.325,4.279,0.36,9.097,0.04,14.544c-0.267,4.537-0.513,9.384-0.552,13.14
						c-0.105,10.048-4.168,21.119-6.634,30.879c-6.605,26.14-24.222,48.368-42.275,50.653c-30.731,3.889-64.693-30.675-67.206-60.39
						C776.957,547.727,753.719,535.785,764.106,510.318z" class="colore89067 svgShape"></path><path fill="#1a1a1a" d="M830.693 521.822c-.89-1.197-2.03-1.95-3.414-1.999-.157-.03-.311-.052-.462-.069-.057-.013-.106-.039-.168-.042-.058-.003-.103.013-.16.012-4.767-.242-7.016 5.989-5.294 9.912.157.906.495 1.753 1.187 2.365.684.605 1.577.951 2.497 1.045.073.048.136.103.229.136 2.131.748 3.842-.276 4.961-2.022C832.464 528.852 832.785 524.635 830.693 521.822zM887.696 544.23c-1.552-2.873-5.223-3.861-7.981-2.078-.244.158-.468.345-.677.548-.717.632-1.197 1.501-1.311 2.512-.018.117-.028.234-.035.352-.001.037-.011.07-.011.107.006 1.789.055 3.609.888 5.239 1.607 3.144 5.728 3.271 8.13 1.014C888.789 549.963 889.022 546.684 887.696 544.23z" class="color1a1a1a svgShape"></path><path fill="#ce5c48" d="M852.463,561.436c-0.104-1.473-1.451-2.663-2.934-2.544c-1.46,0.118-2.919,0.236-4.379,0.353
						c-1.477,0.119-2.648,1.445-2.544,2.934c0.104,1.473,1.451,2.663,2.934,2.544c1.46-0.117,2.919-0.235,4.379-0.353
						C851.397,564.251,852.568,562.925,852.463,561.436z" opacity=".5" class="colorce5c48 svgShape"></path><path fill="#814915" d="M815.855 498.461c8.779-3.858 18.051-6.117 27.635-6.625 1.705-.09 3.158 1.516 3.158 3.158 0 1.785-1.448 3.067-3.158 3.158-8.391.445-16.747 2.379-24.448 5.763-1.56.685-3.391.457-4.32-1.133C813.938 501.441 814.285 499.151 815.855 498.461zM886.414 512.818c1.27-1.165 3.206-1.237 4.466 0 2.906 2.855 5.319 6.273 6.957 10.006.354.805.562 1.549.318 2.433-.202.732-.768 1.526-1.451 1.887-.733.387-1.62.581-2.433.318-.73-.236-1.564-.716-1.887-1.451-.926-2.109-2.097-4.095-3.473-5.94-.778-.977-1.605-1.911-2.497-2.787C885.233 516.124 885.164 513.965 886.414 512.818z" class="color814915 svgShape"></path><path fill="#e89067" d="M706.594,683.888c-0.215,6.388,1.485,49.079,2.317,59.06c7.43-4.288,59.68-46.637,68.514-54.732
				c8.089-7.414,20.739-10.405,30.707-15.308c5.151-2.533,10.746-4.048,16.048-6.223c5.29-2.17,10.43-4.67,15.354-7.582
				c4.275-2.528,8.699-5.281,11.485-9.509c2.274-3.453,3.028-8.134,1.456-11.994c4.508-2.885,8.271-7.153,8.626-12.379
				c0.188-2.774-1.044-5.284-2.997-7.087c0.511-0.241,1.029-0.471,1.534-0.723c3.897-1.948,7.412-4.703,9.078-8.843
				c1.637-4.074,0.614-8.465-2.353-11.634c-0.71-0.759-1.504-1.39-2.348-1.933c5.271-1.438,9.804-5.573,8.946-11.628
				c-0.82-5.781-6.653-8.883-11.927-9.632c-7.439-1.056-14.924,0.654-22.235,1.9c-4.924,0.84-9.848,1.68-14.773,2.519
				c3.762-3.981,7.064-8.39,9.082-13.52c2.419-6.148,3.272-13.619-2.928-17.78c-6.694-4.492-11.22,4.301-14.952,8.765
				c-4.836,5.785-10.488,9.928-15.786,15.3c-4.791,4.857-10.973,8.027-15.866,12.77c-5.17,5.011-7.737,11.544-10.758,17.919
				c-6.299,13.293-17.864,22.762-28.424,32.594c-6.044,5.627-20.799,14.512-24.048,16.832
				C714.525,655.199,707.271,663.768,706.594,683.888z" class="colore89067 svgShape"></path><path fill="#dd8058" d="M732.494,640.477c10.329-5.419,19.571-12.654,27.306-21.387c3.79-4.28,7.173-8.901,10.121-13.799
				c3.205-5.325,5.564-11.064,8.549-16.503c2.97-5.412,6.856-9.885,11.71-13.683c4.623-3.618,9.681-6.678,14.117-10.533
				c4.73-4.111,8.212-9.298,12.265-14.025c3.555-4.146,8.796-9.534,14.587-5.861c5.911,3.749,5.073,12.073,3.708,17.948
				c-1.025,4.407-2.947,8.646-5.757,12.186c2.878-0.588,5.769-1.109,8.674-1.547c6.044-0.91,12.274-1.791,18.398-1.72
				c5.265,0.061,10.89,1.372,14.604,5.37c3.252,3.5,4.366,8.707,2.152,13.06c-1.182,2.324-3.281,3.699-5.568,4.74
				c2.011,1.67,3.589,3.878,4.377,6.37c1.16,3.666-0.499,6.996-3.066,9.9c-1.139,1.288-4.82,4.912-5.576,3.989
				c-0.738-0.9,2.585-5.402,4.013-8.142c0.705-1.283,0.664-3.62-0.112-4.993c-0.776-1.374-2.859-4.152-4.809-4.972
				c-1.851,0.759-3.7,1.525-5.551,2.286c-2.816,1.159-4.043-3.422-1.259-4.567c3.052-1.256,6.122-2.477,9.159-3.769
				c2.328-0.99,4.408-2.145,4.786-4.872c0.779-5.616-5.159-8.776-9.849-9.444c-6.255-0.891-13.123,0.275-19.327,1.167
				c-6.561,0.944-13.057,2.281-19.468,3.965c-2.951,0.775-4.21-3.792-1.26-4.567c0.558-0.147,1.994-1.281,2.459-1.656
				c4.182-3.369,6.842-7.987,8.193-13.149c0.931-3.56,2.884-12.865-2.465-14.023c-2.575-0.557-5.073,2.724-6.557,4.361
				c-1.928,2.127-3.682,4.401-5.464,6.65c-3.599,4.541-7.452,8.497-12.089,11.985c-4.272,3.214-8.846,6.044-12.848,9.606
				c-4.422,3.937-7.382,8.728-9.98,14c-2.458,4.988-4.818,9.982-7.799,14.689c-2.882,4.549-6.147,8.872-9.718,12.903
				c-7.975,9.006-17.615,16.54-28.264,22.128C732.187,645.982,729.79,641.896,732.494,640.477z" class="colordd8058 svgShape"></path><path fill="#d59622" d="M586.736,1041.995c29.742,18.729,64.681,30.261,100.043,29.512
			c16.643-0.352,33.41-3.465,48.78-9.963c13.859-5.859,26.615-14.364,37.455-24.784c21.888-21.043,35.71-50.156,33.917-80.859
			c-1.109-19.001-7.407-37.253-13.841-55.006c-3.17-8.745-6.949-17.5-9.225-26.532c-2.081-8.258-1.533-17.067,5.619-22.674
			c3.109-2.437,6.72-3.966,10.168-5.838c3.444-1.869,6.403-4.26,8.907-7.283c5.016-6.057,7.734-14.065,8.572-21.809
			c1.096-10.138-0.359-20.31-1.984-30.308c-1.645-10.122-3.315-20.24-4.973-30.36c-0.84-5.126-1.68-10.252-2.52-15.378
			c-0.275-1.681,0.439-3.399,2.206-3.884c1.509-0.415,3.607,0.513,3.885,2.205c1.721,10.509,3.444,21.017,5.165,31.526
			c1.717,10.476,3.788,20.98,4.615,31.574c1.351,17.289-2.342,36.986-17.686,47.371c-6.02,4.075-15.55,5.942-16.709,14.408
			c-0.544,3.976,0.524,8.069,1.694,11.834c1.46,4.698,3.206,9.317,4.886,13.94c6.617,18.214,13.698,36.512,16.455,55.802
			c2.379,16.646,1.17,33.403-4.409,49.315c-5.112,14.577-13.29,27.912-23.548,39.431c-10.37,11.646-22.965,21.441-36.79,28.654
			c-15.006,7.829-31.397,12.38-48.202,14.151c-35.97,3.789-72.695-5.702-104.221-22.871c-3.887-2.117-7.701-4.364-11.446-6.723
			C580.118,1045.288,583.284,1039.821,586.736,1041.995z" class="colord59622 svgShape"></path><path fill="#1a1a1a" d="M958.768,1120.846c0,0-20.292,74.542-7.219,84.24c13.072,9.699,35-93.193,35-93.193
			L958.768,1120.846z" class="color1a1a1a svgShape"></path><path fill="#e89067" d="M977.387,1076.289c7.627-12.204,14.258-13.337,19.396-12.042c6.908,1.741,17.469,3.188,29.08,0.439
			c20.282-4.804,37.896,3.202,46.435,10.141c8.54,6.939,22.802,23.964,22.802,23.964s-24.366,0.153-26.678,0.055
			c-4.804-1.068-18.008-12.276-27.081-8.006c-9.074,4.27,9.607,13.344,13.344,22.417s-1.068,24.552-10.675,22.951
			c-9.607-1.601-12.81-11.208-18.147-12.81c-5.337-1.601-14.411-2.135-30.957-2.135s-36.206-0.353-36.206-0.353
			S969.76,1088.492,977.387,1076.289z" class="colore89067 svgShape"></path></g></svg></g></svg></div><section><p>Ciąża dla wielu kobiet nie jest najłatwiejszym okresem w życiu. Zwłaszcza w momencie, kiedy ich dzień determinowany jest przez nudności i wymioty. Oba te objawy dotyczą nawet 50-90 proc. ciężarnych. Co jest ich przyczyną, jak można sobie z nimi radzić, kiedy zwykle występują i kiedy mijają mdłości w ciąży? Sprawdź, co powinna wiedzieć w tym temacie przyszła mama i jej bliscy!</p></section><section><h3>Kiedy zwykle pojawiają się mdłości w ciąży?</h3><p>Jak łatwo wnioskować z powyższych danych, mdłości w ciąży są bardzo powszechnym objawem. Wraz z wymiotami doświadcza ich ponad połowa kobiet w ciąży, a nawet 35 proc. ciężarnych ma z tym na tyle duży problem, że są one skutkiem nieobecności w pracy, pogorszenie stanu psychicznego czy trudności w relacjach.[1] Na szczęście u większości pań nie jest to groźne, a tylko niewielka grupa kobiet może w konsekwencji mierzyć się zi ich komplikacjami : odwodnieniem , zaburzeniami elektrolitowymi czy utratą masy ciała. Dolegliwości te mogą być na tyle niebezpieczne, że konieczny jest pobyt w szpitalu – mowa przede wszystkim o tzw. niepowściągliwych wymiotach ciężarnych, które dotykają około 0,3-2 proc. pań oczekujących dziecka.</p><p>Większość kobiet obserwuje początek mdłości w ciąży w 4. tygodniu po ostatnim krwawieniu menstruacyjnym. Największe nasilenie zazwyczaj następuje około 9. tygodnia ciąży. Dobrą wiadomością jest to, że u 60 proc. ciężarnych objawy te mijają samoistnie, jeszcze przed zakończeniem I trymestru. Około 91 proc. pań pożegna się z nimi do 20. tygodnia ciąży. Czy zatem mdłości w III trymestrze ciąży też mogą być obecne? Owszem, wskazuje się, że 10-20 proc. kobiet może mieć tego typu problem nawet pod koniec ciąży.</p><p>Niezależnie od tego, że powyższe dane nie napawają optymizmem, to i tak u większości pań mdłości w ciąży miną względnie szybko. Mimo to jest to niezwykle trudny objaw. Powoduje duży dyskomfort i skutecznie może zabrać piękno tego wyjątkowego okresu. Co więcej, nie jest to szczególnie korzystne także dla płodu. Wykazano bowiem, że jeśli przyszłe mamy na początku ciąży straciły na wadze, ich dzieci zwykle cechują się niższą masą urodzeniową niż maluchy urodzone przez mamy, które w analogicznym okresie przytyły lub utrzymały niezmieioną masę ciała. Jest też większe ryzyko, że masa urodzeniowa tych dzieci znajdzie się poniżej 10. centyla. Należy jednak zaznaczyć, że dotyczy to przede wszystkim przypadków, w których przyszła mama mierzy się z uporczywymi wymiotami. Jeśli zaś objawy są łagodne lub umiarkowane, nie obserwuje się ich negatywnego oddziaływania na płód. Co więcej, są dane, które wskazują, że jeśli wymioty i mdłości w ciąży są obecne – zachodzi mniejsze ryzyko poronienia!</p></section><section><h3>Przyczyny mdłości w ciąży</h3><p>Choć medycyna nieustannie robi ogromne postępy, odkrywa wciąż nowe fakty, to niestety nie udało się jeszcze znaleźć jednej kluczowej przyczyny występowania wymiotów i mdłości w ciąży. Zauważono jednak, że prawdopodobnie jest to kwestia wynikająca nie tyle z „oddziaływania” samego płodu, co kosmówki (czyli błony płodowej – to z niej wytwarza się trofoblast a potem łożysko). Warto dodać, że fakt braku nudności w pierwszej ciąży nie daje gwarancji, że w drugiej czy kolejnej też one nie wystąpią. Tak samo ich obecność przy pierwszym dziecku nie daje ryzyka, że pojawią się one na pewno w kolejnej ciąży. Produkcja tego hormonu może się zmieniać w kolejnych po sobie ciążach</p><p>Jeśli jednak – mimo wszystko – mdłości u wieloródki występują, zwykle obecne były także we wcześniejszej ciąży (zaobserwowano to u 63 proc. mam oczekujących kolejnego dziecka, które mierzyły się z tego typu objawami).</p><p>Warto przyjrzeć się nieco bliżej konkretnym hipotezom. Wskazuje się, że za wystąpieniem wymiotów i mdłości w ciąży mogą stać:</p><ul><li>niedobory witaminowe</li><li>poziom hormonu hCG</li><li>progesteron</li><li>psychika</li></ul></section></article>',
        '<h3>content2</h3>',
        '19/06/2023'),
       ('layette', 'Gondola dla dziecka: jaką wybrać? Poradnik', 'Title 1',
        'Jaka gondola dla dziecka jest najlepszym wyborem i na co zwrócić uwagę podczas jej zakupu?', 'Description 1',
        'gondola-dziecieca.webp', '<article><h1>Gondola dla dziecka: jaką wybrać?</h1><div class="d-flex justify-content-center"><svg id="SvgjsSvg1444" width="550" height="550" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"><defs id="SvgjsDefs1445"></defs><g id="SvgjsG1446"><svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 3800 3200" viewBox="0 0 3800 3200" width="550" height="550"><path fill="#f2f9f0" d="M3226.1,2633.1c120.6-206.7,232.6-417.1,238.4-635c3.8-142.2-10.9-314.2-186.3-430.2
            c-221.9-146.8-568.2-7.7-815-107.7c-111.6-45.2-153.1-130.1-212.5-194c-75.6-81.3-169-160.3-320.4-207
            c-246.1-75.9-593.2-94.4-810.4,17.2c-274.2,140.9-204.1,339.7-238.9,520.9c-35.1,182.7-398,247.4-483.1,416.3
            c-96.4,191.5,41.7,431.3,170.3,610.4C599.6,2667.8,2726.3,2622.9,3226.1,2633.1z" class="colorf2f9f0 svgShape"></path><ellipse cx="1919" cy="2619.2" fill="#bbd4b7" rx="1553" ry="160.2" class="colorbbd4b7 svgShape"></ellipse><path fill="#c8dcc5" d="M737.3,2338.5c7.6-8.6,16.7-17,29.2-22.1c10.7-4.4,23.2-6.1,35.4-7.5c114.9-12.8,242.4-0.3,338.6-46
        c74.3-35.4,112.9-98.6,184.5-136.7c110.9-59,265.7-43,404.2-33.3c35.1,2.5,71.2,4.3,105.3-2.2c17.8-3.4,34.5-8.9,51.6-13.8
        c117.4-33.2,253.9-31.8,369.7,4c75.7,23.4,143.1,60.6,223.3,75.1c91.7,16.5,188.1,1.2,282.8-1.5c94.6-2.7,202.4,13,251.7,69.7
        c44,50.6,27.7,119.2,74.1,168.7c20.8,22.3,52.6,38.6,74,60.6c21.4,22,29.2,55,1.6,73.3c-19.7,13.1-49.8,13.8-76.9,13.8
        c-378.1,0-756.2-0.1-1134.3-0.2c-189,0-378.1-0.1-567.1-0.1c-167.6,0-337.2-6.7-503.2,9.3C720.7,2565.3,662.4,2423.7,737.3,2338.5
        z" class="colorc8dcc5 svgShape"></path><path fill="#88a484" d="M540.5,2848.9H381.9c-0.7,0-1.3-0.3-1.4-0.7c-0.5-5-6-38-62.7-60.8c-1-0.4-0.5-1.2,0.8-1.3
        c10.1-0.1,41.2,2.1,84.8,29.7c0.9,0.5,2.6,0.2,2.4-0.5c-1.1-6.4-5.5-24.7-21.4-37.2c-0.8-0.6,0.7-1.4,1.9-1
        c13.1,4.4,44.2,16.1,54.2,31.1c0.5,0.7,2.7,0.6,2.7-0.2c0.3-12,3.7-38.1,25.4-54.7c0.8-0.6,2.6-0.3,2.5,0.4
        c-1.8,10.7-7.2,51.8,13.9,63.5c0.8,0.4,2.2,0.2,2.4-0.3c1.7-5.6,10.4-26.9,41.5-33.7c1.3-0.3,2.5,0.4,1.7,1
        c-6,4.6-19.9,17.6-11.9,33.2c0.4,0.7,2.3,0.7,2.7,0c2.4-4.1,10.4-11.8,37.6-17.3c1.2-0.2,2.4,0.4,1.7,1
        c-7.1,6.2-29.8,28.2-19,46.9C542,2848.4,541.4,2848.9,540.5,2848.9z" class="color88a484 svgShape"></path><path fill="#6e856b" d="M772.1,2543.8h158.5c0.7,0,1.3-0.3,1.4-0.7c0.5-5,6-38,62.7-60.8c1-0.4,0.5-1.2-0.8-1.3
            c-10.1-0.1-41.2,2.1-84.8,29.7c-0.9,0.5-2.6,0.2-2.4-0.5c1.1-6.4,5.5-24.7,21.4-37.2c0.8-0.6-0.7-1.4-1.9-1
            c-13.1,4.4-44.2,16.1-54.2,31.1c-0.5,0.7-2.7,0.6-2.7-0.2c-0.3-12-3.7-38.1-25.4-54.7c-0.8-0.6-2.6-0.3-2.5,0.4
            c1.8,10.7,7.2,51.8-13.9,63.5c-0.8,0.4-2.2,0.2-2.4-0.3c-1.7-5.6-10.4-26.9-41.5-33.7c-1.3-0.3-2.5,0.4-1.7,1
            c6,4.6,19.9,17.6,11.9,33.2c-0.4,0.7-2.3,0.7-2.7,0c-2.4-4.1-10.4-11.8-37.6-17.3c-1.2-0.2-2.4,0.4-1.7,1
            c7.1,6.2,29.8,28.2,19,46.9C770.5,2543.3,771.2,2543.8,772.1,2543.8z" class="color6e856b svgShape"></path><path fill="#88a484" d="M826.5 2561.3H681.7c-.7 0-1.2-.3-1.3-.6-.5-4.6-5.5-34.7-57.3-55.6-.9-.4-.5-1.1.7-1.1 9.2-.1 37.6 1.9 77.5 27.1.8.5 2.3.2 2.2-.4-1-5.8-5.1-22.6-19.5-34-.7-.6.6-1.3 1.7-.9 12 4 40.4 14.7 49.5 28.4.5.7 2.4.5 2.4-.2.3-10.9 3.4-34.8 23.2-50 .7-.5 2.4-.2 2.3.4-1.7 9.8-6.6 47.3 12.7 58 .7.4 2 .2 2.2-.3 1.6-5.1 9.5-24.6 37.9-30.8 1.1-.2 2.2.4 1.6.9-5.5 4.2-18.2 16.1-10.9 30.3.3.6 2.1.6 2.4 0 2.2-3.7 9.5-10.8 34.4-15.9 1.1-.2 2.2.4 1.6.9-6.5 5.7-27.2 25.8-17.4 42.8C827.9 2560.9 827.3 2561.3 826.5 2561.3zM3204.6 2923.8h131.1c.6 0 1.1-.2 1.1-.5.4-4.2 5-31.4 51.8-50.3.8-.3.4-1-.7-1-8.3-.1-34.1 1.7-70.2 24.5-.7.4-2.1.2-2-.4.9-5.3 4.6-20.4 17.7-30.8.7-.5-.5-1.1-1.6-.8-10.8 3.6-36.6 13.4-44.8 25.7-.4.6-2.2.5-2.2-.2-.3-9.9-3-31.5-21-45.2-.6-.5-2.2-.2-2.1.4 1.5 8.9 6 42.8-11.5 52.5-.7.4-1.8.2-2-.3-1.4-4.6-8.6-22.2-34.4-27.8-1-.2-2 .4-1.4.8 5 3.8 16.5 14.6 9.9 27.4-.3.6-1.9.6-2.2 0-2-3.4-8.6-9.8-31.1-14.3-1-.2-2 .3-1.4.8 5.9 5.2 24.6 23.4 15.7 38.8C3203.3 2923.4 3203.8 2923.8 3204.6 2923.8zM2559.3 2543h191.8c.9 0 1.6-.3 1.7-.8.6-6.1 7.3-46 75.8-73.6 1.2-.5.6-1.5-1-1.5-12.2-.2-49.8 2.5-102.6 35.9-1 .7-3.1.2-3-.6 1.3-7.7 6.7-29.9 25.8-45 1-.8-.8-1.7-2.3-1.2-15.8 5.3-53.5 19.5-65.6 37.6-.6.9-3.2.7-3.2-.3-.4-14.5-4.4-46.1-30.7-66.2-.9-.7-3.2-.3-3 .5 2.2 13 8.8 62.6-16.8 76.8-1 .5-2.7.3-2.9-.4-2.1-6.7-12.6-32.5-50.3-40.7-1.5-.3-3 .5-2.1 1.2 7.3 5.6 24.1 21.3 14.4 40.1-.4.8-2.7.9-3.2 0-2.9-4.9-12.6-14.3-45.5-21-1.5-.3-2.9.5-2.1 1.2 8.6 7.5 36 34.2 23 56.7C2557.4 2542.4 2558.2 2543 2559.3 2543z" class="color88a484 svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#e0e0e0" d="M3461.2 562.6h-.2-254.9c0 0-82.4-2.7-31.1-54.3 0 0 21.5-18.9 54.2 0 0 0-13.9-31.8 34.7-58.1 0 0 44.4-23.3 98-5.8 0 0 54.3 15.6 51.6 55.9 0 0 48.4-14.1 68.1 17.8C3506.2 557.6 3461.2 562.6 3461.2 562.6M618.4 615h-.1-215c0 0-69.5-1.9-26.3-37.9 0 0 18.1-13.2 45.7 0 0 0-11.8-22.2 29.3-40.6 0 0 37.4-16.2 82.7-4.1 0 0 45.8 10.9 43.5 39 0 0 40.8-9.9 57.5 12.4C656.4 611.6 618.4 615 618.4 615M1530.7 793h-.1-185.7c0 0-60-1.7-22.7-34.1 0 0 8.8-6.7 23.3-5 7.2.8 14.1-2.7 16-8.4 2.3-6.8 8.9-15.3 25.5-23.1 0 0 32.3-14.6 71.4-3.6 0 0 25.5 6.3 34.5 21.8 3.9 6.7 12.1 11.2 21.3 11.3 10.9.1 23.9 2.7 31.4 13.1C1563.5 789.9 1530.7 793 1530.7 793" class="colore0e0e0 svgShape"></path></g><ellipse cx="1998.5" cy="2649.4" fill="#88a484" rx="1059.5" ry="46.5" class="color88a484 svgShape"></ellipse><g fill="#000000" class="color000 svgShape"><path fill="#f5d5e4" d="M1548.9,1089.2c57,0,136.8,8.9,187.7,26.7c-3.8,5.2-114,454.2-125.6,507.6h-551.7
            c-1.2-14.1-1.9-28.4-1.9-42.9C1057.5,1309.2,1277.5,1089.2,1548.9,1089.2z" class="colorf5d5e4 svgShape"></path><path fill="#dba2bc" d="M1593.3,1619c-4.5,18.7-1.9,35.5,5.7,37.3s17.6-11.9,22.1-30.6l115.3-478.2c4.5-18.7,1.9-35.5-5.7-37.3
            c-7.7-1.8-17.6,11.9-22.1,30.6L1593.3,1619z" class="colordba2bc svgShape"></path><path fill="#f5d5e4" d="M2181.8,1625.5v161.7c0,119.5-97.8,217.3-217.3,217.3h-692.7c-119.5,0-217.3-97.8-217.3-217.3v-161.7H2181.8
            z" class="colorf5d5e4 svgShape"></path><circle cx="2095.4" cy="1720.1" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1966" cy="1831.3" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1960.3" cy="1968.7" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1812.8" cy="1959.6" r="26.1" fill="#ffffff" transform="rotate(-31.714 1812.944 1959.693)" class="colorfff svgShape"></circle><circle cx="2110.2" cy="1875.6" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1841.1" cy="1742.8" r="26.1" fill="#ffffff" transform="rotate(-67.5 1841.119 1742.76)" class="colorfff svgShape"></circle><circle cx="1745.8" cy="1850.6" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1518.8" cy="1742.8" r="26.1" fill="#ffffff" transform="rotate(-45.001 1518.76 1742.826)" class="colorfff svgShape"></circle><circle cx="1409.8" cy="1839.3" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1274.7" cy="1767.8" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1178.2" cy="1639.5" r="26.1" fill="#ffffff" transform="matrix(.9999 -.01515 .01515 .9999 -24.697 18.034)" class="colorfff svgShape"></circle><circle cx="1114.7" cy="1742.8" r="26.1" fill="#ffffff" transform="rotate(-67.5 1114.655 1742.762)" class="colorfff svgShape"></circle><circle cx="1162.3" cy="1867.7" r="26.1" fill="#ffffff" transform="rotate(-67.5 1162.33 1867.623)" class="colorfff svgShape"></circle><circle cx="1384.8" cy="1664.5" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1552.8" cy="1882.4" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1438.2" cy="1995.9" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1282.7" cy="1946" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1638" cy="1995.9" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1690.2" cy="1696.3" r="26.1" fill="#ffffff" class="colorfff svgShape"></circle><circle cx="1960.3" cy="1648.6" r="26.1" fill="#ffffff" transform="rotate(-9.6 1960.25 1647.729)" class="colorfff svgShape"></circle><g fill="#000000" class="color000 svgShape"><path fill="#dba2bc" d="M1042.6,1627c0,10.4,15.7,18.9,34.9,18.9h1078.8c19.2,0,34.9-8.5,34.9-18.9c0-10.4-15.7-18.9-34.9-18.9
            H1077.5C1058.3,1608.1,1042.6,1616.6,1042.6,1627z" class="colordba2bc svgShape"></path></g><g fill="#000000" class="color000 svgShape"><circle cx="1608.1" cy="1625.2" r="33.2" fill="#666764" transform="rotate(-22.5 1608.057 1625.158)" class="color666764 svgShape"></circle></g><g fill="#000000" class="color000 svgShape"><circle cx="1608.1" cy="1625.2" r="21.3" fill="#ffffff" class="colorfff svgShape"></circle></g><g fill="#000000" class="color000 svgShape"><path fill="#dba2bc" d="M1252.1,2004.3h721.4c18.6,0,33.8,6.8,33.8,15.1c0,8.3-15.2,15.1-33.8,15.1h-721.4
            c-18.6,0-33.8-6.8-33.8-15.1C1218.3,2011.1,1233.5,2004.3,1252.1,2004.3z" class="colordba2bc svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#7d5c67" d="M1243.9,2388.6c11.7,0,23.8-0.7,36.1-2.2c6.2-0.7,10.7-6.4,9.9-12.6c-0.7-6.2-6.4-10.7-12.6-9.9
                c-67.8,8.1-126.2-8.1-164.4-45.6c-35.7-35-52-87.6-46-148c6.6-65.9,52.2-102.9,147.9-119.7c92.1-16.2,224-12.3,376.7-7.7
                c12.8,0.4,25.8,0.8,39,1.2c79.4,2.3,144.7-4,199.7-19.4c54-15.1,96.7-38.6,130.5-71.8c60.4-59.4,90.8-149.6,95.5-283.9
                c2.2-62.3,23.1-110.4,62.1-142.8c78.8-65.5,206.2-47.4,207.5-47.2c6.2,0.9,12-3.4,12.9-9.6c0.9-6.2-3.4-12-9.6-12.9
                c-1.4-0.2-35-5.1-79.5-1.3c-59.5,5.1-109.9,23.6-145.9,53.5c-44.2,36.8-67.8,90.4-70.3,159.5c-4.5,128.1-32.7,213.4-88.7,268.5
                c-62.4,61.3-165,89-313.6,84.7c-13.2-0.4-26.1-0.8-38.9-1.2c-154-4.6-287-8.6-381.4,8c-105.9,18.6-158.8,63.1-166.5,139.8
                c-6.7,67.4,12,126.5,52.7,166.5C1133,2369.8,1184.4,2388.6,1243.9,2388.6z" class="color7d5c67 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#7d5c67" d="M1685.6,2044.6c0.1-7.8-0.8-15.4-2.8-22.6c120.4-3.6,224.3-4.8,300.8,9c99.2,17.8,148.9,60.7,156.3,134.7
                c6.7,67.4-12,126.5-52.7,166.5c-36.1,35.4-87.4,54.1-146.9,54.1c-11.7,0-23.8-0.7-36.1-2.2c-6.2-0.7-10.7-6.4-9.9-12.6
                c0.7-6.2,6.4-10.7,12.6-9.9c67.8,8.1,126.2-8.1,164.4-45.6c35.7-35,52-87.6,46-148C2104.6,2040.6,1939.6,2037,1685.6,2044.6z" class="color7d5c67 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#7d5c67" d="M1711.5,2560.8c-48.9-48.9-75.9-114-75.9-183.2s26.9-134.3,75.9-183.2c48.9-48.9,114-75.9,183.2-75.9
            c69.2,0,134.3,26.9,183.2,75.9c48.9,48.9,75.9,114,75.9,183.2s-26.9,134.3-75.9,183.2c-48.9,48.9-114,75.9-183.2,75.9
            C1825.5,2636.7,1760.4,2609.8,1711.5,2560.8z M1658.3,2377.6c0,130.3,106,236.4,236.4,236.4c130.3,0,236.4-106,236.4-236.4
            c0-130.3-106-236.4-236.4-236.4C1764.4,2141.3,1658.3,2247.3,1658.3,2377.6z" class="color7d5c67 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><circle cx="1894.7" cy="2377.6" r="53.6" fill="#7d5c67" class="color7d5c67 svgShape"></circle></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1890.4" y="2133.3" fill="#7d5c67" transform="rotate(-180 1894.704 2379.348)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1890.4" y="2132.6" fill="#7d5c67" transform="rotate(134.999 1894.717 2378.599)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1890.4" y="2131.6" fill="#7d5c67" transform="rotate(45.001 1894.74 2377.635)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1890.4" y="2131.6" fill="#7d5c67" transform="rotate(90 1894.703 2377.645)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><path fill="#7d5c67" d="M1103.7,2559.2c-48.9-48.9-75.9-114-75.9-183.2s26.9-134.3,75.9-183.2c48.9-48.9,114-75.9,183.2-75.9
            c69.2,0,134.3,26.9,183.2,75.9c48.9,48.9,75.9,114,75.9,183.2s-26.9,134.3-75.9,183.2c-48.9,48.9-114,75.9-183.2,75.9
            C1217.7,2635,1152.6,2608.1,1103.7,2559.2z M1050.5,2376c0,130.3,106,236.4,236.4,236.4s236.4-106,236.4-236.4
            c0-130.3-106-236.4-236.4-236.4S1050.5,2245.6,1050.5,2376z" class="color7d5c67 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><circle cx="1286.9" cy="2376" r="53.6" fill="#7d5c67" class="color7d5c67 svgShape"></circle></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1282.6" y="2131.6" fill="#7d5c67" transform="rotate(-180 1286.855 2377.657)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1282.6" y="2130.9" fill="#7d5c67" transform="rotate(134.999 1286.866 2376.909)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1282.6" y="2129.9" fill="#7d5c67" transform="rotate(45.001 1286.889 2375.95)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><rect width="8.6" height="492.1" x="1282.6" y="2129.9" fill="#7d5c67" transform="rotate(90 1286.855 2375.954)" class="color7d5c67 svgShape"></rect></g><g fill="#000000" class="color000 svgShape"><path fill="#754732" d="M2526.8,1018.8c-16.7,14.7-43.9,132.8-49.2,156.2c-5.7,25.1-10,41.9-16.4,66.7
        c-18.7,72.7-79,128-130.4,179.3c-8,4.5-14.9,9-20.1,11.8c-15,8.1-29.2,16.8-38.9,27.9c-9.8,11.1-9.5,22.7,3.2,30.6
        c6.9,4.3,14.9,2.6,22.1,0.6c16.5-4.5,47.4-22.8,60.4-30.1c4.4-2.4,8.3-5.6,11.7-9.5c53.2-61.1,119.2-104.5,161.8-175
        c12-19.9,32.9-58,40.1-80.7c6-18.8,29-113.4,32.8-131.1C2612.8,1025.5,2554,994.7,2526.8,1018.8z" class="color754732 svgShape"></path><path fill="#1d1c26" d="M2845.8,534.6c0.9-0.7,1.7-1.4,2.3-2.3c2.2-3.3,1.2-7.5,0.4-9.7c-2.4-6.5-7.5-11.4-12.5-16.2
                c-5.1-4.9-10-9.6-12.2-15.9c-0.8-2.5-1.2-5-1.6-7.8c-0.3-1.8-0.5-3.6-0.9-5.5c-2.8-12.1-12.8-22.1-24.9-24.9
                c-0.7-0.2-1.4-0.3-2.2-0.5c-3.6-0.7-7.3-1.5-9.2-4.3c-1-1.4-1.3-3.2-1.7-5.1c-0.4-2.2-0.9-4.4-2.3-6.2
                c-2.6-3.2-6.7-3.3-10.7-3.4c-2.8-0.1-5.7-0.2-8-1.4c-2.6-1.3-4.1-3.9-5.8-6.6c-1.6-2.6-3.2-5.2-5.9-6.9c-4.1-2.6-9-2.1-13.9-1.5
                c-2.2,0.2-4.4,0.5-6.4,0.4c-1-0.2-2-0.3-3.1-0.4c-1.2-0.3-2.4-0.8-3.4-1.6c-0.5-0.4-1-0.9-1.5-1.4c-0.6-0.6-1.3-1.2-2-1.8
                c-4.9-3.5-10.7-1.2-16.4,1c-0.8,0.3-1.7,0.6-2.5,0.9c-0.9-0.9-1.8-1.9-2.9-2.6c-3.8-2.7-8.4-2.1-13.1-0.6
                c-0.5-0.5-0.9-0.9-1.5-1.3c-5.1-3.7-11.1-1.7-17,0.2c-2.7,0.9-5.4,1.8-8,2.2c-1.2-1.3-2.3-2.6-3.7-3.6
                c-9.1-6.7-21.4,3.5-32.7,3.3c-5.1-0.1-12-1.5-13.9,3.3c-0.5,1.4-0.4,2.9-0.1,4.4c-3.4,0.1-6.6,0.9-7.8,4.1
                c-0.7,1.8-0.4,3.8-0.1,5.4l2.5,15c-0.1-0.1-0.3-0.2-0.4-0.3c-2.2-1.7-3.5-4.4-5.8-6c-5.7-3.9-13.2,1.4-17.5,6.8
                c-0.8,1-1.5,2-2.4,3c-2,1.5-3.9,3.3-5.5,5.3l-0.4,0.5c0,0.1-0.1,0.1-0.1,0.2c-2.3,1.7-4.8,2.7-7.7,2.4c-2.9-0.3-5.6-1.9-8.5-2.1
                c-4.9-0.3-9.3,3.8-10.9,8.5c-3.8,1.4-6.8,5-8,8.7c-0.5,1.5-0.8,3.1-1,4.7c-3.8-0.7-7.6-1.4-11.4-2c-6.1-1.1-13.7-1.6-17.2,3.5
                c-0.9,1.3-1.3,2.7-1.4,4.2c-2.6,0.6-4.9,1.9-6.4,4.2c-4.2,6.2,0.4,14.1,5.1,19.6c4,4.7,8.9,11.7,5.9,17.4
                c-0.7,1.2-1.7,2.3-2.7,3.4c-1.7,1.9-3.6,3.8-3.8,6.5c-0.4,4.5,3.6,7,7.5,9.4c3.5,2.1,6.8,4.2,7,7.5c0,0,0,0,0,0.1
                c-3.7,2.1-7.4,4.2-8.3,7.9c-0.1,0.2-0.1,0.4-0.1,0.6c-3.5,2-7,4.2-7.9,8c-1.1,4.4,1.8,8.4,4.4,11c2.5,2.6,5.4,4.6,8.4,6.4
                c-24.4,11.1-46,25.1-58.1,38.3c-0.7,0.7-1.5,1.6-2.4,2.6c-13.6,14.6-49.6,53-44.9,95c-1.7,26.2,10.6,54.2,52.6,78.8
                c129,75.3,163,67.2,163,67.2s96.7,7.1,132.9-78.5c21.8-51.5,12.7-97.2-10.7-136.1c1.9,0,3.9-0.2,5.8-0.5c0.2,0,0.4-0.1,0.6-0.1
                c4.1-0.8,7.4-2.3,9.9-4.4c2-1.8,3.5-4,5-6.2c1-1.6,2.1-3.2,3.4-4.6c5.7-6.3,14.3-7.4,23.3-8.6c6.7-0.9,13.7-1.8,19.6-5
                c2.9-1.5,6.5-4.3,7.7-8.6c0.2-0.7,0.3-1.3,0.3-2c2.7-1.7,5-4.1,5.9-7.1c1.6-5.6-2.2-11.2-2.8-17c-0.3-2.7,0.1-5.2,0.9-7.6
                c3.9-4,9-7.5,14.2-11c1.8-1.2,3.3-2.3,4.4-3.9c1.1-1.7,1.6-3.6,1.6-5.4c0.2-0.1,0.4-0.3,0.6-0.4c1.6-1,3.1-2.1,4.2-3.7
                c2.1-3,1.6-7.1,0.3-10.6C2849.6,540.2,2847.9,537.3,2845.8,534.6z M2736.9,418.4c4.7-0.5,9.1-1,12.6,1.2
                c2.3,1.5,3.7,3.8,5.3,6.3c1.7,2.8,3.5,5.7,6.5,7.3c2.7,1.4,5.8,1.5,8.9,1.6c3.7,0.1,7.2,0.2,9.3,2.7c1.2,1.4,1.5,3.4,1.9,5.4
                c0.4,2,0.8,4,2,5.8c2.3,3.4,6.6,4.3,10.4,5.1c0.7,0.1,1.4,0.3,2.1,0.5c11.4,2.7,20.9,12.1,23.5,23.5c0.4,1.7,0.7,3.5,0.9,5.3
                c0.4,2.7,0.8,5.5,1.7,8.1c2.3,6.7,7.6,11.8,12.6,16.7c4.8,4.6,9.8,9.4,12,15.5c0.7,1.9,1.6,5.4-0.2,8c-0.5,0.7-1.2,1.3-1.9,1.9
                c-7.8-9.3-19.2-16.6-23.1-28.1c-1.8-5.1-1.9-10.7-3.1-15.9c-3.2-14-14.9-25.7-28.8-29c-5.2-1.2-11.3-1.8-14.3-6.2
                c-2.7-4-1.7-9.7-4.7-13.5c-4.9-6-15.1-1.9-22-5.5c-6.4-3.4-7.9-12.3-14-16.3c0,0,0,0-0.1,0
                C2735.3,418.6,2736.1,418.5,2736.9,418.4z M2704.5,414.5c5.5-2.1,10.6-4.1,14.6-1.2c0.6,0.4,1.2,1,1.8,1.6
                c0.5,0.5,1.1,1.1,1.7,1.6c0.1,0.1,0.2,0.1,0.3,0.2c-7,0.5-14.4,2.4-19.9-1.5C2703.5,414.9,2704,414.7,2704.5,414.5z
                 M2526.1,586.1c-2.4-0.7-4.7-1.6-7.1-2.6c4.4-1.9,9-3.8,13.5-5.5c2.7,0.8,5.5,1.5,8.3,2.1C2535.8,582,2530.9,584,2526.1,586.1z
                 M2667.4,411.2c5.7-1.9,11-3.6,15.3-0.5c0.2,0.1,0.4,0.3,0.6,0.4c-7.6,2.8-15.6,7-21.8,2.8c-0.3-0.2-0.7-0.5-1-0.8
                C2662.8,412.7,2665.1,411.9,2667.4,411.2z M2602.3,423.7c0.9-2.3,3.4-2.9,6.4-2.9c1.2,7.6,2.5,15.2,3.7,22.8
                c-2.2,1.4-5,1.7-7.5,0.9l-2.7-16.4C2602,426.7,2601.8,425.1,2602.3,423.7z M2537.5,471.1c0.9-2.8,3-5.5,5.6-7
                c-0.8,4.1-0.4,8.4,0.1,12.6c-2.2-0.4-4.4-0.8-6.6-1.2C2536.8,474,2537,472.5,2537.5,471.1z M2504.8,503.4
                c-4.2-5-8.5-12.1-4.9-17.3c1.2-1.7,2.9-2.7,4.9-3.3c0.5,4.3,3.4,8.8,6.4,12.3c4.4,5.3,9.3,12.4,6,18.4c-1.3,2.4-3.8,4.3-5.3,6.5
                C2513,514.1,2508.5,507.9,2504.8,503.4z M2511.2,539.7c-3.5-2.2-6.9-4.2-6.6-7.6c0.2-2,1.7-3.7,3.3-5.4c1.1-1.1,2.1-2.3,2.9-3.7
                c0,0,0,0,0,0c-0.6,7.7,13.9,8.9,14.5,16.7c0.3,3.8-2.7,6-6.3,8C2518.3,544,2514.7,541.8,2511.2,539.7z M2506.6,575.1
                c-1.9-1.9-4.8-5.6-3.9-9.2c0.7-2.8,3.2-4.6,6.1-6.3c0.4,2.7,2.3,5.3,4.3,7.3c4.4,4.4,9.7,7.5,15.4,9.7
                c-4.3,1.7-8.5,3.4-12.7,5.3C2512.4,580.1,2509.3,577.9,2506.6,575.1z M2411.3,701.3c4.7-33.9,32.3-63.4,43.8-75.7
                c0.9-1,1.7-1.9,2.4-2.6c12.2-13.3,34.2-27.4,59.1-38.5c2.2,1.1,4.5,2,6.8,2.8c-27.6,12.3-50.9,27.6-63.5,40.9
                C2451.4,637.4,2421.3,666.5,2411.3,701.3z M2765.6,637.8c-1.4,2.2-2.8,4.2-4.6,5.8c-2.2,1.9-5.2,3.3-9,4
                c-2.4,0.5-4.8,0.6-7.2,0.6c-2.2-3.5-4.5-7-6.9-10.4c7,2.1,14.1,3.3,21.4,1.9c2.3-0.4,4.6-1.2,6.6-2.3
                C2765.8,637.5,2765.7,637.7,2765.6,637.8z M2812.6,619c-5.6,3-12.4,3.9-18.9,4.8c-7.1,0.9-14.3,1.9-20.1,5.6
                c1.1-1.6,2.1-3.2,3.4-4.6c10.2-11.2,29-6.7,42.5-13.5c0,0.1,0,0.2-0.1,0.3C2818.6,614.4,2816.2,617.1,2812.6,619z M2842.6,562.4
                c-0.9,1.3-2.3,2.3-3.9,3.4c-3.2,2.1-7,4.6-10.6,7.6c3.7-5.4,9.8-10,15.6-14C2843.6,560.5,2843.3,561.5,2842.6,562.4z" class="color1d1c26 svgShape"></path><path fill="#3b3b3b" d="M2744.5 613.8c.5 0 .9 0 1.4 0 6.2-.3 11.6-3.1 14.5-7.4 1.3-1.9 2-4.1 2.8-6.1 1.1-3.1 2.1-5.9 4.4-7.1 1.4-.7 3.1-.8 5-.9.6 0 1.2-.1 1.9-.1 7.6-.7 14.9-5 19.1-11.5 4.2-6.4 5.2-14.9 2.7-22.1-.7-2.1-1.8-4.2-2.8-6.2-2-3.9-3.8-7.6-3.2-11.4.6-3.7 3.3-6.7 6.3-9.8 3-3.2 6-6.5 7.2-10.9 2-7.4-2.2-15.8-11.4-23-1-.8-2-1.5-3.1-2.3-5.4-4-11-8.2-13-14.2-.4-1.1-1.6-1.8-2.8-1.4-1.1.4-1.8 1.6-1.4 2.8 2.4 7.3 8.6 11.9 14.5 16.3 1 .8 2 1.5 3 2.3 3.7 2.9 12 10.4 9.9 18.4-.9 3.4-3.5 6.1-6.2 9-3.3 3.5-6.6 7.1-7.4 12.1-.8 5.1 1.5 9.6 3.6 14 1 2 1.9 3.8 2.5 5.7 2.1 6 1.2 13-2.2 18.3-3.4 5.3-9.5 8.9-15.8 9.5-.6 0-1.1.1-1.7.1-2.1.1-4.6.2-6.8 1.4-3.8 2-5.2 5.9-6.5 9.4-.7 1.9-1.3 3.7-2.3 5.2-2.1 3.2-6.2 5.2-11.1 5.5-4.6.2-9.4-1-13.9-2.2-1.2-.3-2.4.4-2.7 1.5-.3 1.2.4 2.4 1.5 2.7C2734.9 612.5 2739.7 613.8 2744.5 613.8zM2592.7 759.4c3.2 0 6.4-.2 9.5-.6 6.3-.9 18-4 24.9-13.9.7-1 .4-2.3-.5-3-1-.7-2.3-.4-3 .5-4.4 6.3-12.4 10.7-22 12.1-8.2 1.2-16.7.4-25-.5l-2-.2c-3.6-.4-7.3-.7-10.9-1-14.8-1.3-30.1-2.7-44.6-6.2-20.6-5-36.7-13.6-47.8-25.7-4.3-4.7-9.4-12-8.9-19.8.1-1.2-.8-2.2-2-2.3-1.2-.1-2.2.8-2.3 2-.5 7.5 2.9 15.2 10 23 11.7 12.8 28.5 21.8 50 27 14.9 3.6 30.3 5 45.3 6.3 3.6.3 7.3.6 10.9 1l2 .2C2581.6 758.8 2587.1 759.4 2592.7 759.4zM2622.7 568c1.1 0 2-.8 2.1-1.8.2-1.2-.6-2.3-1.8-2.5l-25.8-4c-1.2-.2-2.5-.4-3.3-.9-2.1-1.3-2.3-4.1-2.3-8.5 0-3.9 0-8.4-2.8-11.6-1.7-1.9-3.9-2.8-5.8-3.7-.9-.4-1.8-.8-2.6-1.2-3.8-2.2-6.4-6.8-6.6-12.2-.2-4.4.9-9 3.5-15.1.4-.9.7-1.6 1.3-2.1.8-.6 2.2-.8 3.4-.9 4.3-.4 8.8-.9 12.9-2.8 4.8-2.3 8.1-6.6 8.6-11.1.1-.8.1-1.6.1-2.3 0-1.4 0-2.6.5-3.4.5-.7 1.4-1.1 2.4-1.6 3.7-1.7 7.5-3 11.5-3.9 1.2-.3 1.9-1.5 1.6-2.6-.3-1.2-1.5-1.9-2.6-1.6-4.2 1-8.3 2.4-12.3 4.2-1.5.7-3.1 1.5-4.2 3.1-1.3 1.9-1.3 4-1.3 5.9 0 .7 0 1.3-.1 1.9-.4 3.6-3.4 6.3-6.2 7.7-3.4 1.6-7.3 2.1-11.3 2.4-1.7.1-4.1.3-5.9 1.9-1.2 1-1.9 2.4-2.4 3.7-2 4.5-4.2 10.6-3.9 17 .3 6.8 3.7 12.8 8.8 15.7 1 .6 2 1 3 1.4 1.7.7 3.3 1.4 4.3 2.5 1.7 2 1.7 5.2 1.7 8.7 0 4.5 0 9.6 4.4 12.2 1.6 1 3.5 1.3 4.9 1.5l25.8 4C2622.5 568 2622.6 568 2622.7 568zM2715.3 803.1c.7 0 1.3-.3 1.7-.9 8.5-11.2 20.6-28.3 27.6-47.9 4.8-13.5 9.3-34 3.1-55.2-.9-2.9-1.9-5.8-2.9-8.6-2.5-7.1-4.9-13.7-4.6-20.7.1-1.2-.9-2.2-2.1-2.3-1.2-.1-2.2.9-2.3 2.1-.4 7.9 2.3 15.2 4.8 22.4 1 2.7 2 5.6 2.8 8.4 5.9 20.1 1.6 39.6-3 52.5-5.2 14.7-13.6 29.1-27 46.7-.7 1-.5 2.3.4 3.1C2714.4 803 2714.8 803.1 2715.3 803.1z" class="color3b3b3b svgShape"></path><path fill="#754732" d="M2965.4,2492.5l-176-440.1c-44-69.2-40.7-535.1-40.7-535.1L2561,1639.4c11.3,165.3,60,360.7,60,360.7
        c22.3,136.9,325.6,531,325.6,531L2965.4,2492.5z" class="color754732 svgShape"></path><path fill="#754732" d="M2504.4 1502.4c-88.2 133.6-122 288.2-122 288.2-4.7 22.6-41.1 103.5-68 195.2-26.8 91.7-50.3 563.1-50.3 563.1l46.8 19.9c0 0 124-541.8 176.9-601.2 0 0 249.3-324.4 264.1-440.8L2504.4 1502.4zM2559.1 913c-7.3 6.5-17.8 23.5-26.8 24.3-34.7 3.3-67.2-59.8-68.8-63.3-4.4 4.2-13.6 3.9-14 1.2-.2-5.6 8.2-34.1 4.5-50.6-5.8-25.1-10.9-67.3-3.4-86.3 7 26.7 39.2 45.6 79.7 55.5 46.6 11.5 88.5 7.5 102.4-20 8.5-13.1 18.1-16.5 22.1-14.5 10.6 5.2 7.7 16.2 7.6 17.6-1.3 10.1-6.8 20.2-11.6 29.7-15.7 31.2-15.8 56.2-16.8 73.2-1.4 25 6 109.2 6 109.2s-31.9 26.5-69.5 8.3c.3-34 .5-75.5-.8-80.6C2568.4 912 2562.7 910 2559.1 913z" class="color754732 svgShape"></path><path fill="#3b1a0b" d="M2529.3,803.5c-40.4-9.9-70.7-35.2-77.7-61.9c-0.6-2.4-0.7-0.9-0.9-3.3c9,25.7,39.6,45.6,80.3,55.6
        c43.5,10.7,79.5,7.8,97.9-13.8C2614.9,807.7,2575.9,815,2529.3,803.5z" class="color3b1a0b svgShape"></path><path fill="#754732" d="M2708.4,1541.4c-13.4,0.5-116.9-2.5-217.1-20.8c-49.6-9.1-72.7,2.4-57.7-49c10.9-35.5,42.2-95.3,45.2-133.1
        c2-24.8-36.6-84.3-46.1-129.3c-15-70.7,36.7-131.9,77.1-183.6c6.8-8,8-40.6,62.4-48.3c21.1,34,53.6,8.9,65.2,2.6
        c4.5-0.6,25.9,0.8,34.4,10c77.6,84.3-25.7,117.2-6.2,383.3C2666.4,1383.1,2721.8,1538.5,2708.4,1541.4z" class="color754732 svgShape"></path><path fill="#ffffff" d="M2484.6,891.4l27.9-10.8c0.6-0.2,1.4,0.7,1.4,1.6c-0.2,9.1-2.5,43-29.2,11.2
                C2484,892.8,2484,891.6,2484.6,891.4z" class="colorfff svgShape"></path><path fill="#f2be66" d="M2564.8,978.6c-2.8-4.5-29-10.5-63.7,39c-20.7,29.6-32.5,64.7-42.4,99.6l14.2,4
                    c9.5-33.7,23.3-66,40.9-96.1c7.3-12.5,16.5-26.7,28.9-36.9C2547.4,984.3,2559.7,979.9,2564.8,978.6z" class="colorf2be66 svgShape"></path><path fill="#f5be62" d="M2819.4,1793.6c-28-275.8-134.9-412.1-134.9-412.1l29.2-222.4c0.8-6.1-2.2-12.2-7.7-15.1
                    c-36.6-19.5-52.7-59-58.2-76c-1.5-4.6-6.1-7.4-10.9-6.7l-168.8,26.5c-5.1,0.8-9.2,4.7-10.3,9.7c-3.6,16.2-28.1,27.2-42.7,70.2
                    c-8.3,24.4-2.8,34,3.7,63.9l35.3,123.7c0,0-76.1,162.8-95.6,405.1c-1.8,7-1.8,9-2.8,11.5c-7.6,18.2-15.6,90.2,5.6,87.4
                    c5.8-0.8,11.2-3.6,16.7-5.7c25.8-10,56.7-2.7,76.4,17.9c6.2,6.5,11.5,14.3,18.7,19.5c17.7,12.5,41,5.8,61.4-0.5
                    c20.3-6.3,44.7-11,60.6,4.1c3.5,3.3,23,10,27.8,9.1c30.1-5.4,33.8-25.2,50.6-33.1c16.9-7.9,29-17,47.4-17.5
                    c16.8-0.5,29,1.4,39.3,9.4c17,13.3,44.4,34.2,59.5,15.3C2834.8,1858.6,2819.4,1793.6,2819.4,1793.6z" class="colorf5be62 svgShape"></path><path fill="#fdeed5" d="M2639.2 1392.9c-13.2 0-27.1-.8-40.4-4.7-1.3-.4-2.5-.8-3.8-1.1-2.5-.8-4.9-1.6-7.2-2-3.7-.7-7.7-.8-12.3-.7-2.2 0-4.4 0-6.6.1-16.2.2-32.9.4-49.4-3.8-4-1-7.8-2.2-11.5-3.4-5.5-1.7-10.7-3.4-15.8-4.2-3.9-.6-7.5-.5-11.4-.3-8.3.3-17.7.7-27.5-7-4-3.1-4.7-8.9-1.5-12.9 3.1-4 8.9-4.7 12.9-1.5 4.2 3.3 8 3.3 15.3 3 4.4-.2 9.4-.4 15 .5 6.5 1 12.6 3 18.5 4.9 3.6 1.1 7 2.2 10.4 3.1 14.2 3.6 29 3.4 44.7 3.2 2.2 0 4.5-.1 6.7-.1 5.3 0 10.5 0 15.9 1.1 3.3.6 6.3 1.6 9.2 2.5 1.1.4 2.2.7 3.4 1 16 4.6 33.4 4.2 50.3 3.7 5.9-.2 8.6-.5 11.4-.8 3.1-.4 6.3-.7 13-.9 5.1-.1 9.3 3.9 9.4 8.9s-3.9 9.3-8.9 9.4c-5.9.2-8.6.5-11.4.8-3.1.4-6.3.7-13 .9C2649.7 1392.7 2644.5 1392.9 2639.2 1392.9zM2443.1 1159c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2448.2 1160.4 2443.1 1159 2443.1 1159zM2472.3 1113.8c-2.3-.3-4.5 1.6-5.3 3.8s-.5 4.6-.2 7c.1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2477.3 1115.1 2472.3 1113.8 2472.3 1113.8zM2521.5 1120.8c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2526.6 1122.2 2521.5 1120.8 2521.5 1120.8zM2601 1134.8c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2606 1136.2 2601 1134.8 2601 1134.8zM2664.6 1131.8c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2669.6 1133.1 2664.6 1131.8 2664.6 1131.8zM2626.1 1093.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2631.1 1094.6 2626.1 1093.2 2626.1 1093.2zM2601 1226.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2606 1227.7 2601 1226.3 2601 1226.3zM2472.3 1446.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2477.3 1447.7 2472.3 1446.3 2472.3 1446.3zM2462.4 1383.7c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2467.5 1385.1 2462.4 1383.7 2462.4 1383.7zM2644.1 1348.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2649.2 1349.5 2644.1 1348.2 2644.1 1348.2zM2651.3 1272.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2656.4 1273.6 2651.3 1272.2 2651.3 1272.2zM2543.1 1258.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2548.2 1259.5 2543.1 1258.2 2543.1 1258.2zM2567.6 1501.9c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2572.6 1503.3 2567.6 1501.9 2567.6 1501.9zM2593.7 1450.4c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2598.8 1451.8 2593.7 1450.4 2593.7 1450.4zM2719.4 1537.1c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2724.4 1538.5 2719.4 1537.1 2719.4 1537.1zM2636.9 1395.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2642 1396.6 2636.9 1395.3 2636.9 1395.3zM2633.8 1530.1c-2.3-.3-4.5 1.6-5.3 3.8s-.5 4.6-.2 7c.1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2638.8 1531.5 2633.8 1530.1 2633.8 1530.1zM2663.9 1477.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2668.9 1478.5 2663.9 1477.2 2663.9 1477.2zM2608.2 1627.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2613.2 1628.8 2608.2 1627.5 2608.2 1627.5zM2686.2 1756.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2691.3 1757.6 2686.2 1756.2 2686.2 1756.2zM2793.4 1747.8c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2798.5 1749.2 2793.4 1747.8 2793.4 1747.8zM2807.8 1848c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2812.9 1849.4 2807.8 1848 2807.8 1848zM2746.9 1812.6c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2751.9 1814 2746.9 1812.6 2746.9 1812.6zM2626.5 1690.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2631.6 1691.9 2626.5 1690.5 2626.5 1690.5zM2671.8 1613.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2676.9 1614.8 2671.8 1613.5 2671.8 1613.5zM2736.2 1634.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2741.2 1635.9 2736.2 1634.5 2736.2 1634.5zM2719.4 1691.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2724.4 1692.9 2719.4 1691.5 2719.4 1691.5zM2644.1 1812.6c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2649.2 1814 2644.1 1812.6 2644.1 1812.6zM2779 1606.4c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2784.1 1607.8 2779 1606.4 2779 1606.4zM2691.9 1439.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2697 1440.7 2691.9 1439.3 2691.9 1439.3zM2493.8 1520.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2498.9 1521.7 2493.8 1520.3 2493.8 1520.3zM2562.5 1577.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2567.5 1578.7 2562.5 1577.3 2562.5 1577.3zM2528.7 1691.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2533.8 1692.9 2528.7 1691.5 2528.7 1691.5zM2576.9 1749.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2582 1750.6 2576.9 1749.2 2576.9 1749.2zM2597.7 1861.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2602.8 1862.6 2597.7 1861.3 2597.7 1861.3zM2501.1 1613.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2506.1 1614.8 2501.1 1613.5 2501.1 1613.5zM2380.3 1668.6c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2385.4 1670 2380.3 1668.6 2380.3 1668.6zM2449 1647.8c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2454 1649.1 2449 1647.8 2449 1647.8zM2394.7 1733.8c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2399.8 1735.2 2394.7 1733.8 2394.7 1733.8zM2362.3 1823.1c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2367.3 1824.5 2362.3 1823.1 2362.3 1823.1zM2472.3 1737.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2477.3 1738.6 2472.3 1737.3 2472.3 1737.3zM2493.8 1868.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2498.9 1869.6 2493.8 1868.3 2493.8 1868.3zM2435.1 1802.1c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2440.2 1803.5 2435.1 1802.1 2435.1 1802.1zM2528.7 1805.6c-2.3-.3-4.5 1.6-5.3 3.8s-.5 4.6-.2 7c.1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2533.8 1807 2528.7 1805.6 2528.7 1805.6zM2420.7 1577.3c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2425.8 1578.7 2420.7 1577.3 2420.7 1577.3zM2519.2 1311.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2524.3 1312.6 2519.2 1311.2 2519.2 1311.2zM2557.6 1176.7c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2562.6 1178.1 2557.6 1176.7 2557.6 1176.7zM2644.1 1180.4c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2649.2 1181.8 2644.1 1180.4 2644.1 1180.4zM2671.8 1230.7c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2676.9 1232 2671.8 1230.7 2671.8 1230.7zM2564.8 1093.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2569.8 1094.6 2564.8 1093.2 2564.8 1093.2zM2497.4 1183.8c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2502.4 1185.1 2497.4 1183.8 2497.4 1183.8zM2462.4 1230.7c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2467.5 1232 2462.4 1230.7 2462.4 1230.7zM2601 1308.5c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2606 1309.9 2601 1308.5 2601 1308.5zM2543.1 1421.2c-2.3-.3-4.5 1.6-5.3 3.8-.8 2.2-.5 4.6-.2 7 .1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2548.2 1422.6 2543.1 1421.2 2543.1 1421.2zM2427.9 1494.9c-2.3-.3-4.5 1.6-5.3 3.8s-.5 4.6-.2 7c.1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2433 1496.3 2427.9 1494.9 2427.9 1494.9zM2450.3 1304.2c-2.3-.3-4.5 1.6-5.3 3.8s-.5 4.6-.2 7c.1.6.2 1.3.6 1.8.5.5 1.2.7 1.9.8 3.5.7 7.7 1.2 10.1-1.4 2.1-2.2 1.9-6-.1-8.4C2455.4 1305.6 2450.3 1304.2 2450.3 1304.2z" class="colorfdeed5 svgShape"></path><path fill="#754732" d="M2336.5,1415.5c10.3-14.3,79.2-29.3,95.9-33.8c10.7-2.9,85.7-40.7,111.8-52.4
        c118.4-52.6,116.8-72.8,85.4-195.6c-11.4-43.8-17.8-172.8,69.5-136.5c44.3,18.4,32.8,78.8,34.8,117.4
        c7.3,142.2,28.8,237.4-129,274.6c-33.3,7.8-134.7,32.8-137.6,33c-13.5,1.2-92.1,30.1-105.2,34.1
        C2350.4,1459.9,2319.8,1438.6,2336.5,1415.5z" class="color754732 svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#1d1c26" d="M2486.3,806.6c-0.7-0.2-1.4-0.6-1.8-1.3c-0.8-1-5.2-3.8-7.7-4.9c-3.3-1.3-7-1.5-10.1-0.4
                c-0.6,0.7-1.5,1.1-2.5,1c-1.5-0.2-2.6-1.6-2.4-3.1c0.1-0.8,0.5-2.2,2.5-3c4.4-1.7,9.9-1.6,14.5,0.3c2,0.8,9,4.6,10.4,7.3
                c0.7,1.4,0.3,3.1-1.1,3.8C2487.7,806.7,2487,806.8,2486.3,806.6z M2484.5,805.3C2484.5,805.3,2484.5,805.3,2484.5,805.3
                C2484.5,805.3,2484.5,805.3,2484.5,805.3z M2467.4,798.5C2467.4,798.5,2467.4,798.5,2467.4,798.5
                C2467.4,798.5,2467.4,798.5,2467.4,798.5z" class="color1d1c26 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#1d1c26" d="M2486.1,829.6c1.1,6-1.1,11.5-5,12.2c-3.9,0.8-7.9-3.5-9.1-9.5s1.1-11.5,5-12.2
                C2480.9,819.3,2484.9,823.6,2486.1,829.6z" class="color1d1c26 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#ad695e" d="M2550.3,841.7c-4.4,6.9-11.1,10.4-14.9,7.8c-3.9-2.5-3.4-10.2,0.9-17c4.4-6.9,11.1-10.4,14.9-7.8
                C2555.1,827.3,2554.7,834.9,2550.3,841.7z" class="colorad695e svgShape"></path></g><path fill="#140703" d="M2650.2,795.5c-1.2-3.3-2.6-6.6-4.2-9.7c-0.5-0.9-1.5-3-3.5-3.8c0.8-0.6,1.7-1.2,2.5-1.8
        c2.3-1.5,5.2-3.5,8.2-3.6c0.7,0,1.3-0.6,1.3-1.4c0-0.7-0.6-1.3-1.4-1.3c-3.8,0.1-7,2.3-9.6,4c-2.4,1.6-5.3,3.5-6.9,6.5
        c-0.9,1.7-1.3,3.5-1.6,5.2l-3.2,14.7c-0.2,0.7,0.3,1.4,1,1.6c0,0,0,0,0,0c0.7,0.2,1.4-0.3,1.6-1l3.2-14.7c0.3-1.5,0.7-3.1,1.4-4.5
        c0.3-0.6,0.7-1.1,1.1-1.6c0.2,0.2,0.5,0.4,0.8,0.4c0.8,0.1,1.6,0.9,2.5,2.6c1.6,3,2.9,6.1,4,9.3c0.2,0.5,0.6,0.8,1,0.9
        c0.2,0.1,0.5,0,0.8-0.1C2650.1,797.1,2650.4,796.3,2650.2,795.5z" class="color140703 svgShape"></path><g fill="#000000" class="color000 svgShape"><path fill="#1d1c26" d="M2267.1,2529.5c7.3,10.5,19.1,17.1,30.9,20.7c6.8,2.1,22.3-0.7,27,3.5c9.8,8.9-0.3,52.4-6,63.6
                    c-14.6,28.8-37.4,17.9-60.7,20c-23.9,2.2-43.7,20.6-68.1,18.9c-23.4-1.6-57.4-17.2-70.1-38c-13.2-21.8,3.9-39.5,25.2-40.9
                    c21.4-1.4,41.5,4.9,63.2-1.6c12.1-3.6,24-9.8,33.2-19.8C2246.1,2551.2,2260.6,2520.1,2267.1,2529.5z" class="color1d1c26 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#1d1c26" d="M2973.1,2668.4c-19.7-13.3-14.9-51.7-14.5-56.5c1.7-11,2.9-22.5-0.9-32.5c-13.2-35-19-42.9-26.4-51.3
                c-8.4-9.6-10.6-20.8-6.5-24.4c9-9.9,19.8-16.5,27.9-27.3c2.4-2.7,7.3-8.1,15.4-8.7c11.6-0.8,25.3,7.3,31.1,9.9
                c11,5,29,6.8,18.9,54.2c-1.1,4-2.2,7.9-3.2,11.9c-3.1,12-5.3,24.1-3,37.2c0.3,4.1,1.1,36.2-1.1,49.3
                C3006.4,2655.4,2992.8,2681.7,2973.1,2668.4z" class="color1d1c26 svgShape"></path></g><g fill="#000000" class="color000 svgShape"><path fill="#f5be62" d="M2677.4,991c-0.1-3.7-28.2-23.3-50.5,26.9c-5.4,12.2-9.4,23.2-12.5,33.4c-1.2,4.1-3.1,10.5-4.2,14.7
                c1.2,2.1,2.7,2.3,2.8,4.8c0.3,5.7,3.4,11.1,4.6,16.8c2.7-10.6,5.5-21.1,8.6-31.4c2.8-9.6,6.7-19.9,11.7-31.5
                c13.4-30.6,23.7-36.5,28.6-37.3c2.1-0.3,3.7,0.2,4.8,0.8c2.2,0.6,4.4,1.9,5.7,3.7c0,0,0,0.1,0.1,0.1c0.1-0.2,0.2-0.4,0.4-0.6
                C2677.4,991.2,2677.4,991.1,2677.4,991z" class="colorf5be62 svgShape"></path></g></g></g></svg></g></svg></div><section><p>Gondola dla dziecka to obowiązkowy element wyprawki każdego świeżo upieczonego rodzica. Możesz zdecydować się na wózek 2 w 1, czyli razem ze spacerówką, 3 w 1, czyli z dodatkowym fotelikiem samochodowym, lub dokupić samodzielnie specjalne głębokie uzupełnienie. Jaka gondola dla dziecka jest najlepszym wyborem i na co zwrócić uwagę podczas jej zakupu?</p></section><section><h3>Gondola dla dziecka – do jakiego wieku?</h3><p>Chcesz kupić gondolę i nie wiesz, do jakiego wieku jest obowiązkowa? Głęboki wózek jest rekomendowany przynajmniej przez <strong>pierwsze 3 miesiące życia</strong>. Powód jest prosty – dzięki niemu maluch będzie mógł spędzać mnóstwo czasu na spacerach w pozycji leżącej, która jest uznawana za najzdrowszą w przypadku niemowlaków.</p><p>A kiedy zrezygnować z gondoli dla dzieci? Przyjęło się, że optymalnym momentem na zamianę wózka jest osiągnięcie przez malucha 6. lub 7. miesiąca życia, ale nie tylko. Może to nastąpić wcześniej, gdy dziecku zacznie brakować miejsca na rączki i nóżki lub zacznie coraz częściej siadać i być ruchliwe.</p></section><section><h3>Dlaczego gondola dla niemowlaka to dobry wybór?</h3><p>Wózek gondola dla dziewczynki lub chłopca to nie tylko wsparcie prawidłowej pozycji kręgosłupa i zapewnienie mu wygody. To także <strong>praktyczna ochrona przed niekorzystnymi warunkami atmosferycznymi</strong>, takimi jak deszcz, wiatr, śnieg, niskie temperatury, a nawet intensywne słońce.</p><p>Nie bez znaczenia jest także fakt, że maluch <strong>może bezpiecznie i wygodnie spać</strong>nawet w trakcie najdłuższych spacerów. Konstrukcja gondoli sprawia, że głęboki wózek jest najlepszym sposobem na popołudniową drzemkę na świeżym powietrzu. Co ciekawe, wielu rodziców wykorzystuje gondolę nie tylko na dworze, ale także w domu. W takich sytuacjach pełni ona funkcję kołyski, która sprawdzi się równie doskonale w podróży.</p></section><section><h3>Jaka gondola dla dziecka? Podpowiadamy, na co zwrócić uwagę podczas zakupu</h3><p>Co sprawdzić, wybierając gondolę dla dziecka? Podstawą jest <strong>wielkość i waga wózka</strong>, zwłaszcza jeśli mieszkasz w bloku bez windy. Wypinana część nie powinna przekraczać 5 kg. Z kolei modele ze stelażem mogą ważyć nawet mniej niż 7 kg.</p><p>Kolejną kwestią jest <strong>wykonanie gondoli dla niemowlaka</strong>. Wykorzystane materiały powinny być przede wszystkim wytrzymałe. W przypadku stelaża sprawdzi się aluminium lub stal. Równie ważny jest materacyk, który musi być miękki, przyjemny w dotyku i jednocześnie bezproblemowy w czyszczeniu. Dobrym rozwiązaniem jest postawienie na model, do którego produkcji wykorzystano tkaniny z certyfikatami.</p><p>Nie bez znaczenia są też koła w wózku gondoli dla dziewczynki lub chłopca. Najpopularniejszym rozwiązaniem są elementy gumowe, czyli <strong>piankowe</strong>, które są cenione za lekkość idącą w parze z dobrą amortyzacją. Są też praktyczne, ponieważ nie musisz ich pompować, a także mogą pochwalić się trwałością i odpornością na uszkodzenia.</p><p>Innym rozwiązaniem są <strong>koła żelowe</strong>. Ich nazwa może być myląca, ponieważ żel wykorzystuje się wyłącznie do pokrycia gumy, z której powstają elementy gondoli. Do ich zalet możemy zaliczyć wygodę, brak konieczności pompowania i pewne prowadzenie. Dodatkowo zapewniają znakomitą amortyzację.</p><p>Jeśli kupujesz wózek z gondolą dla noworodka, to warto rozważyć też model z <strong>kołami pompowanymi</strong>. Rodzice cenią je za płynność prowadzenia, amortyzację i możliwość używania nawet na nierównej nawierzchni. Są jednak mniej wytrzymałe od poprzednich propozycji i wymagają napompowania.</p><p>Co jeszcze ma znaczenie podczas zakupu gondoli dla dziecka? <strong>Praktyczne dodatki</strong>, które zwiększą komfort i bezpieczeństwo korzystania z tego typu wózka. Obowiązkowo zainwestuj w model z hamulcem i amortyzatorami. Dobrym wyborem są również skrętne koła i ich blokada, dodatkowy pałąk bezpieczeństwa oraz zdejmowana tapicerka, którą z łatwością wypierzesz w pralce.</p></section></article>',
        '<h3>content1</h3>',
        '12/12/2023'),
       ('layette', 'Jak wybrać łóżeczko dla niemowlaka?', 'Title 1',
        'Ten wybór to jedna z pierwszych decyzji jaka staje przed przyszłymi rodzicami. Jak szybko się okazuje wcale nie jest to taka prosta decyzja.',
        'Description 1', 'lozeczko.webp',
        '<article><h1>Jak wybrać łóżeczko dla niemowlaka?</h1><div class="d-flex justify-content-center"><svg id="SvgjsSvg1543" width="550" height="550" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"><defs id="SvgjsDefs1544"></defs><g id="SvgjsG1545"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 3000 3000" width="550" height="550"><g data-name="Layer 2" fill="#000000" class="color000 svgShape"><path fill="#eb673d" d="M1572.9,1671.75S1868.51,1834,1871.51,1834c42.94-7,341.54-78.89,341.54-78.89L2261,1995.82s-386.23,47.5-406.46,37c-160.79-83.89-322.57-299.6-322.57-299.6Z" class="coloreb673d svgShape"></path><path fill="#629fcf" d="M2154.13,2293.42c-257.66,162.78-395.47,504.33-387.49,560.25s105.86,69.91,155.8,37.95,289.61-621.17,289.61-621.17Z" class="color629fcf svgShape"></path><path fill="#ffaa85" d="M2599.53 2702.88c25-2 102.87-29 122.84-27 29 37 76.9 237.69 76.9 237.69l-156.79 2c17-25 56.92-33 62.91-42.94s-16-96.87-42.94-101.86-65.91-5-65.91-5zM2371.84 2702.88c25-2 102.86-29 122.83-27 29 37 76.9 237.69 76.9 237.69l-156.79 2c17-25 56.93-33 62.92-42.94s-16-96.87-42.95-101.86-65.91-5-65.91-5z" class="colorffaa85 svgShape"></path><path d="M2371.84,2702.88c25-2,102.86-29,122.83-27,29,37,76.9,237.69,76.9,237.69l-156.79,2c17-25,56.93-33,62.92-42.94s-16-96.87-42.95-101.86-65.91-5-65.91-5Z" style="mix-blend-mode:multiply" fill="#ffe3d5" class="colorffe3d5 svgShape"></path><path fill="#71b7ed" d="M2192.93,2283.68c-156.64,128.58-322.42,452.15-320.43,566,16,55.93,69.91,61.92,103.87,61.92s515.31-73.9,643.14-139.82c-8-49.93-18-73.9-18-73.9-69.9,6-331.56-26-383.49-16,315.58-125.83,389.48-177.76,397.47-213.71S2261.7,2251,2192.93,2283.68Z" class="color71b7ed svgShape"></path><path fill="#629fcf" d="M2608.83,2720.8c-253.25-.65-493.49,44.39-511.95,58.6-11,8.47-26,7.55-32.53,1.43-3.57-3.33-3.78-7.61-.61-12.38,6.77-10.14,8.57-15.41,6.67-19.44s-6.69-5.1-13.81-5.9c9.88-23.33,146.78-186.49,206.31-257.46,18.07-21.53,32.34-38.54,38.85-46.53l1.53-1.87-1.52-1.89c-12.34-15.43-26.57-71.15,14.56-105.18l-3.83-4.61c-42.67,35.31-29.8,92.53-16.85,111.56-7,8.55-20.53,24.65-37.33,44.67-35.49,42.3-89.12,106.23-132.44,159.65-78.75,97.13-76.8,101.9-75.52,105.06a3.69,3.69,0,0,0,3.1,2.29c3.75.37,10.73,1.07,11.53,2.77.44.92.21,3.9-6.23,13.56-4.81,7.21-4.24,14.71,1.5,20.08,4.28,4,11,6.36,18.45,6.36a35.92,35.92,0,0,0,21.82-7.42c17.57-13.52,261.42-57.94,509.87-57.33C2609.86,2724.7,2609.34,2722.68,2608.83,2720.8Z" class="color629fcf svgShape"></path><path fill="#ff7042" d="M2192.33,1760.88c-18.73,152,9.73,258.41,24.71,322.82s-89.88,208.22-62.91,209.72c56.92-1.5,112.35-6,158.79,64.42s196.24,160.28,349,112.35c4.5-343.05-46.44-677.1-303.34-824.66C2311.42,1643.29,2203.56,1730.17,2192.33,1760.88Z" class="colorff7042 svgShape"></path><polygon fill="#c1d7eb" points="1586.38 674.08 1282.29 522.78 1130.99 618.15 1435.09 769.45 1586.38 674.08" class="colorc1d7eb svgShape"></polygon><polygon fill="#d1ebff" points="1414.11 991.16 1110.02 839.86 1130.99 618.15 1435.09 769.45 1414.11 991.16" class="colord1ebff svgShape"></polygon><path fill="#f06a3f" d="M789,731.5c36.95,41,151.8,131.83,151.8,131.83,25-42,120.83-159.79,120.83-159.79l44,37c-24,80.89-73.91,239.68-100.87,249.67s-44.94,26-65.91,11S790.94,937.23,788,919.25,789,731.5,789,731.5Z" class="colorf06a3f svgShape"></path><path fill="#ffaa85" d="M683.09,2062.73c-26.57,99.17-170.9,631.73-203.27,751.18a25.79,25.79,0,0,0,17.1,31.33c110.59,35.23,182.69,55.41,190.16,70.35H338.55c4-51.93,33-60.69,48.93-131.82,51.93-231.69-8.08-344.25,26-521.31,39.94-207.72,93.87-299.6,93.87-299.6Z" class="colorffaa85 svgShape"></path><path d="M683.09,2062.73c-26.57,99.17-170.9,631.73-203.27,751.18a25.79,25.79,0,0,0,17.1,31.33c110.59,35.23,182.69,55.41,190.16,70.35H338.55c4-51.93,33-60.69,48.93-131.82,51.93-231.69-8.08-344.25,26-521.31,39.94-207.72,93.87-299.6,93.87-299.6Z" style="mix-blend-mode:multiply" fill="#ffe3d5" class="colorffe3d5 svgShape"></path><path fill="#ffaa85" d="M776,2062.73c-26.56,99.17-170.89,631.73-203.27,751.18a25.81,25.81,0,0,0,17.11,31.33c110.59,35.23,182.69,55.41,190.16,70.35H431.42c4-51.93,33-60.69,48.94-131.82,51.93-231.69-8.09-344.25,26-521.31,39.95-207.72,93.88-299.6,93.88-299.6Z" class="colorffaa85 svgShape"></path><path fill="#381c11" d="M908,499l-5.27-1.36c.1-.4,10.13-40,.49-55.79-3.4-5.57-7.66-9.66-11.42-13.28-7.29-7-14.18-13.65-8.11-26.59,7.64-16.27,7.54-38.16-15.65-50.79A26.73,26.73,0,0,1,854.2,333.7c-4.83-19.41,8.78-45.56,21-64.08,7.4-11.18,10-20.43,8.16-29.12-3-14-17.8-28.73-49.61-49.12l2.94-4.59c33.6,21.54,48.66,36.78,52,52.59,2.15,10.21-.69,20.77-9,33.25-16.48,24.89-23.69,46.11-20.29,59.75,1.54,6.22,5.19,10.82,11.14,14.06,26.54,14.45,26.27,40.21,18,57.89-4.41,9.4-.37,13.29,7,20.35,4,3.84,8.52,8.19,12.29,14.36C918.69,456.75,908.42,497.31,908,499Z" class="color381c11 svgShape"></path><path fill="#381c11" d="M585.32,505.19c21.82,2.53,43.57-1.74,43.57-1.74-15.13-17.58,1-42.23,1-42.23-3.87,24.55,9.92,44.86,9.92,44.86s66.76,2.15,73.55-.63,8-16.42,8-16.42L731,499.85l13.65,4c31.33-.27,47.52-18.12,44.51-50.78,11.11,24.42-5,46.35-5,46.35,36.87,10.58,95.33-2.18,95.33-2.18,6.58-25.94,4.94-58.61-6-66.69S875.86,396.45,869,387s-69.69-26.64-48.18-59.51,62-76.81,42.65-108-34.31-31-35.91-58.26S770,125,740.05,125.21c-39.7-22.81-61.71-48.5-101.12-38.63s-35,50.7-65,41.42-47.53,16.75-58.25,37.28-48.82,24.93-64.94,50.95-2.34,45,.61,70.82-7.88,34.12-14.53,53.25,22.32,61.1,39.42,69.12c14.13,22.48-1.85,41.46,10.13,53.44s27,5,26,24S555.47,529.54,585.32,505.19Z" class="color381c11 svgShape"></path><path fill="#ffaa85" d="M677.19,435.82c-12.84-8.33-44.08,27-25.14,82.08,14.56,42.33,23.55,61.8,50.51,94,0,0-82.39-83.14-181.61-53.06,0,0,38-34.75,25.43-81.46,0,0,8.42-6.14,4.58-29.11,0,0,4.85.76,17.22-4.94s16.22-12,13.94-36.43-1.41-42.09,21.24-54.78S645,305.91,645,305.91s15.89-11.07,13.56-24.25,6.14-11.08,19.46-8.22,25.64-1.32,24.5-23.3,2.44-28.87,19.28-31.38,27.45-20.16,21.94-38.61c22.06,25.07,32,46.71,32.6,77.2s-9.91,53.32-3.07,68.16a196.65,196.65,0,0,0,17.06,28.88c-1.81,9.08-27,24.43-27,24.43-4.24,18.46-16,71.1-33,71.48S691.27,443.58,677.19,435.82Z" class="colorffaa85 svgShape"></path><path fill="#381c11" d="M759.22,295.38l-13-.9a7.27,7.27,0,0,0-1.48-.11,7.17,7.17,0,0,0-6.9,7.41l.27,7.4a7.15,7.15,0,0,0,14.29-.51l-.26-7.4a6.91,6.91,0,0,0-.31-1.76Z" class="color381c11 svgShape"></path><circle cx="628.02" cy="313.01" r="28.75" fill="#ffaa85" transform="matrix(.85 -.52 .52 .85 -70.93 375.13)" class="colorffaa85 svgShape"></circle><path d="M634.58 296.37a19.18 19.18 0 00-24 12.55l2.61.82A16.45 16.45 0 01633.76 299a15.76 15.76 0 012.39 1 11.09 11.09 0 00-1.5 21.54l.82-2.62a8.37 8.37 0 014.75-16.05 16.43 16.43 0 014.3 16.74l2.61.82A19.18 19.18 0 00634.58 296.37zM655.12 404.75c-4.09 6.24-21.64 54.64-8 92-5.66-42.71 19-68.18 30.12-61a129.35 129.35 0 0031.29 11.8C685.11 435.9 659.25 398.45 655.12 404.75z" style="mix-blend-mode:multiply" fill="#ffe3d5" class="colorffe3d5 svgShape"></path><path fill="#ffffff" d="M721.51,379.5a35.38,35.38,0,0,0,28.32,46.75A268.43,268.43,0,0,0,760,393Z" class="colorfff svgShape"></path><path fill="#381c11" d="M763,272.31c-.21,0-21.12-1.55-36.42,9.83L725,280c16.14-12,37.36-10.43,38.26-10.36Z" class="color381c11 svgShape"></path><path fill="#572b1a" d="M695.2 173.6c3.38 20.86-10.32 32.86-24.5 35.18-10.56 1.72-11.2 12.9-11.76 22.77-.61 10.8-1.48 18-8.1 19.68-4.74 1.19-13 1.56-22.47 2-26.44 1.19-59.35 2.67-59.72 22.91-.44 23.48-22.3 39.83-43.69 45.62-24.36 6.58-30.16 14.71-27 37.86 2.06 15.11-4.41 22.65-13.36 33.07-3.07 3.59-6.56 7.64-9.89 12.33-.62.87-1.23 1.7-1.83 2.51a25.8 25.8 0 003.35 1.9c.32.51.6 1 .89 1.52.66-.89 1.33-1.8 2-2.77 3.2-4.49 6.45-8.27 9.6-11.94 9.12-10.63 17-19.82 14.62-37.36-2.8-20.58 1.06-25.93 23-31.86 23.43-6.34 47.23-24.47 47.71-50.77.28-15.13 31.63-16.55 54.53-17.58 9.81-.44 18.28-.82 23.55-2.15 11-2.77 11.63-14.4 12.21-24.66s1.39-16.73 7.2-17.7c17.3-2.82 32.8-18 29-41.43zM445.18 329.87c-.67-1.31-1.35-2.67-2-4.06-1 2-2 4.06-3 6.21.05.11.11.23.17.34 4.53 8.81 7.52 14.62.44 24.89-.74 1.07-1.47 2.21-2.18 3.37.74 2.11 1.63 4.26 2.61 6.43a69.3 69.3 0 014.05-6.71C454.2 347.39 450 339.27 445.18 329.87zM619.25 151.12A183.08 183.08 0 00598.6 156c-13.14 4.25-16 14.25-18.49 23.07s-4.44 15.63-15.24 17.23c-18.22 2.71-62 12.83-75.15 48.26-5.09 13.71-17.42 19.49-29.34 25.08-3.77 1.76-7.56 3.55-11.1 5.6q.62 2.78 1.14 5.65a121.8 121.8 0 0112.27-6.32c12.32-5.77 26.27-12.32 32.14-28.12 12.14-32.7 53.58-42.2 70.84-44.76 14.27-2.12 17.14-12.22 19.68-21.12 2.34-8.24 4.56-16 14.93-19.38a177.19 177.19 0 0120-4.75c18.93-3.73 38.5-7.6 43.83-26.48l-5.24-1.48C654.46 144.16 637.35 147.54 619.25 151.12z" class="color572b1a svgShape"></path><path fill="#ff7d61" d="M721.51,379.5c16.27,4.76,40.12,6.88,40.12,6.88L760,393C750.17,392.42,721.51,379.5,721.51,379.5Z" class="colorff7d61 svgShape"></path><path fill="#ff7042" d="M521,558.85c-61.06,43.32-314.23,316-320.22,347.42C241.18,1030.6,440.41,1140,440.41,1140c24-9,43.44-44.94,43.44-44.94-4.49-1.5-143.8-196.24-143.8-196.24l118.34-82.39c44.94,88.38,131.82,157.29,106.36,245.67s-145.31,161.79-163.29,449.4-21,533.29-21,533.29c128.83,86.89,455.39,27,455.39,27,3-128.83,59.93-467.38,128.83-674.1s82.89-403.47-17-487.36S813.91,824.38,817.91,780.44c2.27-25,2.6-47.69,2.47-62.65a24.67,24.67,0,0,0-16.83-23.25c-22.68-7.55-59-24.67-101-82.63C616.18,530.77,545.56,547,521,558.85Z" class="colorff7042 svgShape"></path><path fill="#e6663d" d="M282.93 900.92l-1.11-2.78c37.77-15.11 58.68-.85 59.54-.25l-1.13 1C340 898.78 319.08 886.46 282.93 900.92zM556.87 778.93l-.23-3c-36.39 2.83-75.11 23.12-98.25 40.61L459.7 819c15.81-12 39-25.94 64-33.48l22.42 2.94.39-3-15.45-2A151.38 151.38 0 01556.87 778.93z" class="colore6663d svgShape"></path><path fill="#ffaa85" d="M481.73 1098.51c17.48 17 53.56 19 59.55 37s-8 52.93-2.5 72.91c-8.49 3-16 3-18.47-7.49s1.49-34.46-5-29.46-34.95 53.92-40.94 73.9-18 65.91-18 65.91c-7.49.5-10-10-10-10-12-13-7.49-60.92 2-97.87s1.37-57.42-3.49-65.28C468 1123.73 481.73 1098.51 481.73 1098.51zM1061.58 703.54s28-44.94 41-82.89 21-45.94 42.94-43.94 62.92-6 68.91-7c6-2 8 28-18 30s-64.91 18-64.91 18c-4 5-6 95.88-6 95.88-4 10-20 27-20 27C1072.57 738.49 1061.58 703.54 1061.58 703.54z" class="colorffaa85 svgShape"></path><polygon fill="#d1ebff" points="1586.38 674.08 1282.29 522.78 1210.39 310.06 1514.48 461.36 1586.38 674.08" class="colord1ebff svgShape"></polygon><path fill="#695547" d="M771.47,1504v723.54h30V1537c0-35.74,27.79-66.18,63.51-67.45a65.92,65.92,0,0,1,68.32,65.87v692.08h33V1537c0-35.74,27.79-66.18,63.51-67.45a65.92,65.92,0,0,1,68.32,65.87v692.08h36V1537c0-35.74,27.79-66.18,63.51-67.45a65.92,65.92,0,0,1,68.31,65.87v692.08h33l3-692.08a65.92,65.92,0,0,1,131.83,0l-3,692.08H1471V1504a91.38,91.38,0,0,0-91.38-91.37H862.85A91.38,91.38,0,0,0,771.47,1504Z" class="color695547 svgShape"></path><path fill="#7d6555" d="M795.44,1504v723.54h30V1537c0-35.74,27.79-66.18,63.51-67.45a65.91,65.91,0,0,1,68.31,65.87v692.08h33V1537c0-35.74,27.79-66.18,63.51-67.45a65.91,65.91,0,0,1,68.31,65.87v692.08h36V1537c0-35.74,27.79-66.18,63.5-67.45a65.92,65.92,0,0,1,68.32,65.87v692.08h33l3-692.08a65.92,65.92,0,0,1,131.83,0l-3,692.08H1495V1504a91.38,91.38,0,0,0-91.38-91.37H886.82A91.38,91.38,0,0,0,795.44,1504Z" class="color7d6555 svgShape"></path><circle cx="838.38" cy="1369.15" r="47.94" fill="#7d6555" class="color7d6555 svgShape"></circle><path fill="#695547" d="M811.42,1370.65a47.91,47.91,0,0,1,40.89-47.36,48,48,0,1,0-6.89,93.23A47.94,47.94,0,0,1,811.42,1370.65Z" class="color695547 svgShape"></path><circle cx="1427.1" cy="1364.66" r="47.94" fill="#7d6555" transform="rotate(-9.22 1426.695 1364.34)" class="color7d6555 svgShape"></circle><path fill="#695547" d="M1400.13,1366.16a47.92,47.92,0,0,1,40.9-47.37,48,48,0,1,0-6.89,93.23A48,48,0,0,1,1400.13,1366.16Z" class="color695547 svgShape"></path><polygon fill="#ffbe73" points="1714.31 2915.59 815.91 2915.59 726.03 2148.61 1804.19 2148.61 1714.31 2915.59" class="colorffbe73 svgShape"></polygon><polygon fill="#f0b26d" points="1367.18 2148.61 726.03 2148.61 815.91 2915.59 1367.18 2915.59 1367.18 2148.61" class="colorf0b26d svgShape"></polygon><polygon fill="#ffbe73" points="574.23 2317.39 1216.38 2317.39 1367.18 2148.61 725.03 2148.61 574.23 2317.39" class="colorffbe73 svgShape"></polygon><polygon fill="#f0b26d" points="1901.46 2304.41 1465.05 2304.41 1367.18 2148.61 1803.6 2148.61 1901.46 2304.41" class="colorf0b26d svgShape"></polygon><polygon fill="#ffbe73" points="1132.49 2534.1 1101.78 2540.03 1090.92 2555.01 1073.88 2534.23 1068.64 2531.23 1059.84 2535.91 1053.47 2533.1 1022.01 2550.7 994.28 2534.1 994.28 2915.59 1132.49 2915.59 1132.49 2534.1" class="colorffbe73 svgShape"></polygon><path fill="#381c11" d="M2307.61,1581.6c13.93,13.27,13.93.44,31.41-20.78s84.69-35.37,87.14-102.36-57-75.42-80-120.53-36.47-98-86.88-93.77-84.48,63.67-68.57,107.23,70.28,196.14,70.94,204.1S2307.61,1581.6,2307.61,1581.6Z" class="color381c11 svgShape"></path><path fill="#ffaa85" d="M2212.29,1322c-29.63,20.64-44.53,77.09-53.53,88.88s-55.72,23.87-57.49,28.29,12.08,25.36,11.05,30.08c-6.79,17-23.76,91.39-16.53,101.12s61.17,28.76,61,31.26c34.77,52.91,35.67,156.77,35.52,159.27,76.4-71.15,166.28-115.35,166.28-115.35l-42.7-61.41c-23.58-18-21.84-66.95-21.84-66.95l-18.57-22c-23.59,3.38-40.68-30.82,17.55-80.19-10.76-9.44,6.94-32.28,6.94-32.28C2231.29,1404.83,2177.35,1364.43,2212.29,1322Z" class="colorffaa85 svgShape"></path><circle cx="2292.43" cy="1511.25" r="27.28" fill="#ffaa85" transform="rotate(-57.58 2292.304 1511.241)" class="colorffaa85 svgShape"></circle><path d="M2296.31,1496.77a18.2,18.2,0,0,1,5.5,25.12l-2.19-1.4a15.61,15.61,0,0,0-4.71-21.54,16.07,16.07,0,0,0-2.17-1.14A10.52,10.52,0,0,1,2278,1512l1.4-2.19a7.94,7.94,0,0,0,8.79-13.23,15.57,15.57,0,0,0-14.8,7.07l-2.19-1.4A18.2,18.2,0,0,1,2296.31,1496.77Z" style="mix-blend-mode:multiply" fill="#ffe3d5" class="colorffe3d5 svgShape"></path><path fill="#381c11" d="M2216.64,1416.43l4.23-2.18c-10.5-20.46-30-29.23-30.84-29.59l-1.92,4.36C2188.3,1389.1,2206.93,1397.52,2216.64,1416.43Z" class="color381c11 svgShape"></path><path d="M2156.81,1601.61c8,12.2,14.21,27.12,19,42.86,13.82-10.82,18.53-51.64,30-66.35,7.49-9.73-72.65,21.73-110-7.77C2103,1580.08,2157,1599.11,2156.81,1601.61Z" style="mix-blend-mode:multiply" fill="#ffe3d5" class="colorffe3d5 svgShape"></path><path fill="#ffffff" d="M2108.44,1492l74.15,6.74C2154.88,1554.16,2100.2,1551.91,2108.44,1492Z" class="colorfff svgShape"></path><path fill="#381c11" d="M2185.92,1433.44h0a5.41,5.41,0,0,1-2.69-7.16l3.68-8.12a5.41,5.41,0,0,1,7.16-2.69h0a5.41,5.41,0,0,1,2.69,7.16l-3.68,8.11A5.41,5.41,0,0,1,2185.92,1433.44Z" class="color381c11 svgShape"></path><path d="M1851.3,2224.56l-47.7-75.95H1661.78l82.89,10.74C1764.82,2203.81,1819.73,2219.26,1851.3,2224.56Z" style="mix-blend-mode:multiply" fill="#ffe3d5" class="colorffe3d5 svgShape"></path><path fill="#ffaa85" d="M1875.5,2160.6l-108.86-63.92-76.89,29-28,23,82.89,4c29,63.91,130.83,71.9,130.83,71.9Z" class="colorffaa85 svgShape"></path><path fill="#ff7042" d="M1875.5,2160.6s260.15-16,291.61-50.43l130.33-307.1,224.7,191.75S2274.89,2271.35,2236,2276.44c-182.76,24-360.52-51.93-360.52-51.93Z" class="colorff7042 svgShape"></path><path fill="#eb673d" d="M2281.3 1839l-5.67-1.94c21.06-61.78 51.52-126.9 146.94-117.36l-.6 6C2330.93 1716.57 2301.62 1779.39 2281.3 1839zM2506.17 2014.44l-7.81 4.46c14-14.51 23.12-24.09 24.95-26l-4.34-4.13c-2.53 2.64-253.17 265-285.29 281-31.55 15.78-82.79 2.9-83.3 2.77l-1.49 5.81a195.63 195.63 0 0044 5.33c14.57 0 30.37-2 43.43-8.55 25.33-12.67 174.34-165.37 247.2-240.87l25.58-14.62z" class="coloreb673d svgShape"></path><path fill="#ffaa85" d="M1572.9 1671.75c-35-53.93-12-96.62-36-108.61s-32.46-70.15-43.44-77.14-16.48 33.45-14.48 56.42 15 35 15 35l2 129.82c20 5 36 26 36 26zM1427.1 1556.4c13.48-7.49 55.92 14 50.43 30s-31 4-33 9 24 12 18.48 25.47-14 14.48-14 14.48c7 16.48 0 29 0 29 2.49 13-7.49 36-17.48 33s-22-28-13-46.94S1386.65 1583.37 1427.1 1556.4z" class="colorffaa85 svgShape"></path><path fill="#71b7ed" d="M2212.61,1028.18c0-166.79-135.21-302-302-302s-302,135.22-302,302,135.21,302,302,302a300.72,300.72,0,0,0,130.79-29.72l60.86,51.5-23-73.26A301.67,301.67,0,0,0,2212.61,1028.18Z" class="color71b7ed svgShape"></path><path fill="#ffffff" d="M1932.5,977.38c.77-14.07-13.31-21.29-25.88-21.29-13.33.37-25.88,8-25.88,26.25h-57.48c-1.15-57.87,38.06-85.27,85.27-86.41,55.57-1.52,89.45,35.39,89.45,79.93,0,56.35-56,68.9-53.3,114.59h-67.37C1870.84,1030.29,1929.46,1020.4,1932.5,977.38Zm-59,158c0-21.32,16.75-35,37.3-35,20.94,0,37.69,13.7,37.69,35,0,20.92-16.75,34.65-37.69,34.65C1890.25,1170,1873.5,1156.28,1873.5,1135.36Z" class="colorfff svgShape"></path></g></svg></g></svg></div><section><p>Jakie łóżeczko dla niemowlaka? Ten wybór to jedna z pierwszych decyzji jaka staje przed przyszłymi rodzicami. Jak szybko się okazuje wcale nie jest to taka prosta decyzja. Obecnie producenci prześcigają się nie tylko w szerokiej ofercie różnorakich modeli, kolorów i wzorów, ale i materiałów z jakich są zrobione. Nic więc dziwnego, że wielu rodziców stawia sobie pytanie – jakie łóżeczko dla noworodka? Jakie będzie bezpieczne, funkcjonalne a jednocześnie estetyczne?</p></section><section><h3>Kiedy kupić łóżeczko niemowlęce?</h3><p>Nasze rozważania możemy rozpocząć od trudnego pytania – kiedy kupić łóżeczko dla dziecka? No cóż, odpowiedzi może być kilka i każda z nich będzie jak najbardziej prawidłowa. Część rodziców decyduje się na nie wiele tygodni przed pojawieniem się Malucha na świecie, a inni czekają do ostatniej chwili, aby nie zapeszać. Jednak my polecamy zakup i skręcenie łóżeczka przynajmniej miesiąc lub dwa przed prognozowanym terminem pojawienia się dziecka. Pozwoli to na spokojne rozwiązanie ewentualnych problemów, które mogą powstać przy skręcaniu mebla, a także da łóżeczku czas na ustanie się i wywietrzenie. Wcześniej skręcone łóżeczko pozwoli też na systematyczne i sukcesywne szykowanie wyprawki łóżeczkowej, czyli materacyka, prześcieradeł, czy ochraniaczy wodoodpornych. Pamiętajmy, że termin porodu to tylko prognozowana data narodzin Twojego malucha, a niektóre dzieciątka szykują się szybciej do przyjścia na świat, dlatego warto być przygotowanym odpowiednio wcześniej by uniknąć dodatkowych nerwów w tej ważnej chwili.</p></section><section><h3>Jaki wybrać rozmiar łóżeczka?</h3><p>Kolejnym ważnym pytaniem jest to dotyczące rozmiaru łóżeczka dla dziecka. W ofercie większości producentów mamy dwa standardowe rozmiary. Pierwszy to 120 x 60, z reguły wystarcza ono do drugich, maksymalnie trzecich urodzin dziecka. W większości modeli posiada ono kilka wyciąganych szczebelków, a w niektórych przypadkach ściągany bok, co ułatwia starszemu dziecku wyjście z łóżeczka. Mniejszy rozmiar łóżeczka rekomendujemy klientom zazwyczaj w przypadku, gdy łóżeczko ma stać w sypialni rodziców lub gdy pokoik dziecka jest niewielki. Jeśli rodzice planują w krótkim czasie mieć drugie dziecko (różnica wieku 2-3 lata), wówczas mniejsze łóżeczko jest również warte rozważenia, gdyż starsze rodzeństwo będzie musiało oddać łóżeczko młodszemu potomkowi.</p><p>Drugie najpopularniejsze łóżeczko to łóżeczko w rozmiarze 140x70 centymetrów. Zdecydowanie wystarczy ono na dłużej - do piątego, a nawet szóstego roku życia. Ten model łóżeczka daje się przerobić na mały tapczanik dla przedszkolaka, co jest wygodne zwłaszcza dla starszych dzieci. Jeśli mamy odpowiednią przestrzeń w pokoju dziecka, to warto rozważyć właśnie ten większy model łóżeczka, gdyż posłuży nam dwa razy dłużej, a różnica w cenie pomiędzy większym a mniejszym modelem jest stosunkowo niewielka.</p></section><section><h3>A może łóżeczko dostawne?</h3><p>Łóżeczka dostawne to osobna kategoria łóżeczek niemowlęcych, która zasługuje na chwilę uwagi. Są to łóżeczka mocowane do lóżka rodziców przy pomocy specjalnych pasów, czy rzepów. Pozwalają one na spanie razem z dzieckiem, ale na osobnych płaszczyznach. Jest to wygodne szczególnie dla Mam, które często karmią w nocy oraz dla tych które chcą mieć malucha blisko siebie. Jak wybrać łóżeczko dostawne? Przede wszystkim warto mieć na uwadze, że posłuży ono rodzicom przez kilka miesięcy. W naszej ofercie znajdziecie kilka uniwersalnych łóżeczek-dostawek, które idealnie sprawdzą się na pierwsze miesiące. Warto zwrócić uwagę na mocowania dostawek, tak, aby w nocy łóżeczko nie odsunęło się od łóżka rodziców, a także na możliwość jego regulacji góra-dół, tak aby wygodnie dopasować je do wysokości małżeńskiego łóżka.</p></section><section><h3>Gdzie kupić łóżeczko?</h3><p>Bez wątpienia najlepszym wyborem miejsca, gdzie można kupić łóżeczko dla noworodka są salony specjalizujące się w meblach dziecięcych. Znajdziecie w nich nie tylko profesjonalną pomoc i doradztwo, ale będziecie mogli realnie zobaczyć wybrany przez Was model łóżeczka niemowlęcego na żywo. Co więcej, wykwalifikowany personel również chętnie pomoże w doborze materaca do łóżeczka, a także pozostałych elementów takich jak poduszki klin, prześcieradła, czy ochraniacza wodoodpornego. Jednak najważniejsze tak naprawdę jest to, że łóżeczka dla dzieci sprzedawane w salonach posiadają wszystkie niezbędne atesty i są w 100% bezpieczne dla noworodków. Kupując łóżeczko niemowlęce w salonie macie pewność, że każdy z materiałów użytych do jego produkcji został dokładnie sprawdzony, a samo łóżeczko nie jest zagrożeniem dla noworodka.</p></section><section><h3>Gdzie ustawić łóżeczko?</h3><p>A gdzie ustawić łóżeczko w pokoju dziecka? Dla wielu rodziców najwygodniejszą opcją będzie postawienie łóżeczka tak, aby mieli do niego nie tylko łatwy dostęp, ale i mogli zobaczyć śpiące dziecko uchylając drzwi pokoju. Dzięki temu nie ma konieczności wchodzenia do pokoju i ryzyka obudzenia dziecka, aby sprawdzić, czy wszystko jest ok. Łóżeczko niemowlęce nie powinno stać bezpośrednio pod grzejnikiem, czy oknem balkonowym. W sezonie zimowym, ciepło grzejnika może powodować przegrzanie maluszka, jednocześnie wyższa temperatura nie jest dogodna dla dobrego snu dziecka. Ustawiając łóżeczko niemowlęce upewnijcie się, czy macie wygodny dostęp do niego, przykładowo, że nie uderzysz głową w wiszący skos nad nim, lub nie zahaczysz nogą o wystającą komodę. Wszystko to jest szczególnie istotne gdy wyjmujemy malucha z łóżeczka w nocy, gdy jesteśmy zaspani, nie mamy pełnej kontroli ruchów i łatwo o ewentualny wypadek.</p><p>Dylematów przy wyborze łóżeczka jest wiele – jakie wybrać, gdzie je ustawić, gdzie kupić. Jednak bez względu na to, czy kupimy łóżeczko niemowlęce z płyty MDF, czy drewna, czy białe, czy ozdobne zadbajmy również o to, aby pasowało do pomieszczenia, a przede wszystkim podobało się rodzicom. W końcu będzie im towarzyszyć przez kilka pierwszych lat życia ich dziecka.</p></section></article>',
        '<h3>content1</h3>',
        '12/12/2023');


DROP TABLE IF EXISTS user_images;

CREATE TABLE user_images
(
    id         SERIAL PRIMARY KEY,
    user_id    INT REFERENCES "users" (id),
    name       VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
