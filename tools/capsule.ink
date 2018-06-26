// inventory
VAR has_cover = false   // обшивка капсулы
VAR has_knife = false   // обмотанный осколок
VAR has_wrench = false  // разводной ключ
VAR has_glass = false   // осколок стекла
VAR has_papers = false  // бумаги
VAR has_tape = false    // изолента

>>> IMG gfx/intro.png

* [Начать игру] -> start

== start
>>> CLEAR
Темнота.
Холод.
Запах металла.
Пробуждение от анабиоза оказалось совершенно не таким, как я представлял.
Но почему до сих пор не сработала автоматика? Капсула уже должна была открыться!

- (start_exam)
* [Открыть глаза]
    Я совершенно ничего не вижу. Надеюсь, с моими глазами всё в порядке.
* [Ощупать стенки капсулы]
    Я попытался вытянуть руку, и мои пальцы натолкнулись на холодный металл. Ощупывая стенки капсулы, я обнаружил какой-то рычаг.
    * * [Потянуть рычаг]
        Я потянул рычаг, и металлический колпак капсулы со скрежетом распахнулся. Свет ударил мне в глаза. Подождав, пока глаза привыкнут к свету, я неуклюже выбрался из капсулы. 
        * * * [Осмотреться] -> chamber_room
-
-> start_exam

== chamber_room

VAR chamber_door_open = false
>>> CLEAR
Круглая камера слабо освещена. В центре возвышается сложная конструкция из механизмов, труб и проводов, вокруг которой расположены капсулы.
Герметичная дверь в стене {chamber_door_open: открыта|плотно закрыта}.

- (chamber_exam)

* [Осмотреть лампы]
    Гладкие металлические стены и пол тускло блестят в полумраке. Видимо, мощности хватает только на резервное освещение.
* (seen_apparate) [Осмотреть конструкцию]
    Только благодаря этой машине стало возможным наше путешествие. Индикаторы на панели управления светятся мягким янтарным светом.
* {seen_apparate} [Осмотреть панель управления]
    Одного взгляда на индикаторы было достаточно, чтобы понять -- остальные капсулы вышли из строя. Выходит, из нас пятерых только мне повезло достичь точки назначения живым.
    Я осмотрел панель. Похоже, с помощью переключателей можно перенаправить питание с капсул на дверь. Главное - подобрать нужное напряжение...
    * * [Переключить питание]
        >>> PUZZLE
    * * * [Открыть дверь]
    На щитке загорелась зеленая лампа. Где-то загудели механизмы, управляющие дверными замками. 
    ~ chamber_door_open = true
+ [Осмотреть капсулы]
    Всего капсул пять. Моя капсула открыта. {not has_cover: Внутри виднеется кожаная обшивка.} 
    * * [Потрогать обшивку]
        Обшивка капсулы до сих пор теплая.
    * * {has_glass} [Вырезать обшивку стеклом]
        Стекло слишком острое, не хотелось бы порезать руки.
    * * {has_knife} [Вырезать обшивку]
        На то, чтобы вырезать обшивку из капсулы, ушло немало времени.
        ~ has_cover = true
    - -
+ {chamber_door_open} [Пройти в хранилище] -> storage_room
- 
-> chamber_exam


== cutscene1
>>> IMG gfx/out.png
Профессор с самого начала предупреждал нас, что это путешествие в один конец.
Но цель того стоила. Увидеть своими глазами то, о чем мы сейчас только мечтаем -- кто бы отказался от такой перспективы? И я вызвался добровольцем.
Вот только почему нас никто не встречает?

* [...] ->->
    
== storage_room
VAR storage_door_open = false
VAR glass_cube_broken = false
VAR engine_room_open = false

{not cutscene1: -> cutscene1 -> storage_room}
{glass_cube_broken: Пол в центре помещения усеян осколками стекла{not has_papers:, среди которых лежит несколько листов бумаги}.|Посреди помещения тускло поблескивает стеклянный куб.} Вдоль стен выстроились ряды однообразных металлических ящиков. В полу возле входа в камеру виден небольшой люк. 
{storage_door_open: Створки двери хранилища частично раскрыты.|Огромная двустворчатая дверь хранилища закрыта.}

- (storage_exam)
* {not glass_cube_broken} [Осмотреть куб]
    Под стеклом лежали несколько страниц отпечатанного на машинке текста. Содержание документа я прекрасно помнил -- ещё бы, ведь я был одним из тех, кто его составлял... 
    - - (seen_cube)
* {seen_cube && has_wrench} [Разбить куб ключом]
    Раздался звон разбитого стекла, и осколки разлетелись по полу.
    ~ glass_cube_broken = true

* {glass_cube_broken} [Осмотреть осколки]
    В осколках отражается желтый свет ламп.
    - - (seen_glass)
* {seen_glass && not has_glass} [Взять осколок]
    Я осторожно подобрал осколок с пола.
    ~ has_glass = true
* {seen_glass && not has_papers} [Взять бумаги]
    Я вытащил из-под осколков листы, сложил их и спрятал в карман.
    ~ has_papers = true
* {has_papers} [Осмотреть бумаги]
Несколько страниц отпечатанного на машинке текста. Для тех, кто должен был нас встретить, они имеют особое значение.
* {has_tape && has_glass && not has_knife} [Обмотать изолентой осколок]
    Аккуратно, чтобы не порезаться, я обмотал осколок изолентой. Теперь им можно пользоваться как ножом, если понадобится.
    ~ has_knife = true
    ~ has_glass = false

* [Осмотреть ящики]
    Надписи на ящиках уже не разобрать. А обыскивать их наугад у меня нет ни времени, ни желания. 
    Между ящиками лежит разводной ключ. Интересно, кто мог обронить его тут?
    - - (seen_boxes)
* {seen_boxes} [Взять разводной ключ]
    Я подобрал с пола разводной ключ. 
    ~ has_wrench = true
* {not has_wrench} [Потянуть крышку люка]
    Я потянул за ручку, но открыть люк у меня не вышло.
* {has_wrench} [Открыть люк]
    Используя разводной ключ как рычаг, я приподнял люк и отодвинул его в сторону.
    ~ engine_room_open = true

* {not storage_door_open} [Осмотреть дверь хранилища]
    Хранилище спроектировано так, что дверь можно открыть только снаружи. Мне нужно найти способ открыть её изнутри.
* {storage_door_open} [Открыть дверь хранилища]
    Похоже, за эти годы механизмы пришли в негодность, и дверь невозможно открыть полностью.
    Из темной щели между створками двери веет холодом.
    * * [Протиснуться в щель]
        Ширины щели вполне достаточно, чтобы я смог протиснуться.
        -> stairs_room
+ {stairs_room} [Идти к лестницам] -> stairs_room
+ {engine_room_open} [Спуститься в люк] -> engine_room
+ [Перейти в камеру] -> chamber_room

-
-> storage_exam

== engine_room
VAR used_cover = false

Тесное небольшое помещение. От гула машин, поддерживающих работу комплекса, звенит в ушах. Рядом с лестницей, ведущей наверх, находится пульт управления. Справа от пульта виден вентиль системы управления гермодверью хранилища{used_cover:, на который наброшена кожаная обшивка капсулы}.
{not has_tape: На полу лежит моток изоленты, слегка присыпанный пылью.}

- (engine_exam)
* [Осмотреть пульт]
Большая часть индикаторов на пульте горит красным. Похоже, долго эти машины не протянут.
* {not used_cover} [Повернуть вентиль]
    - - (tried_vent)
    Я схватил вентиль, но тут же отдернул руку - раскаленный металл больно обжёг ладони.
+ {tried_vent && has_cover} [Набросить обшивку на вентиль]
    Я набросил кожаную обшивку на вентиль.
    ~ has_cover = false
    ~ used_cover = true
+ {used_cover} [Снять обшивку с вентиля]
    Осторожно, чтобы не обжечься, я снял обшивку с вентиля.
    ~ has_cover = true
    ~ used_cover = false
* {used_cover} [Повернуть вентиль]
    Я прокрутил вентиль до упора. Что-то загрохотало в темноте за переплетением труб, и вскоре сверху послышался скрежет открывающейся гермодвери.
    ~ storage_door_open = true
* {not has_tape} [Взять изоленту]
    Я подобрал изоленту.
    ~ has_tape = true
* {has_tape && has_glass && not has_knife} [Обмотать изолентой осколок]
    Аккуратно, чтобы не порезаться, я обмотал осколок изолентой. Теперь им можно пользоваться как ножом, если понадобится.
    ~ has_knife = true
    ~ has_glass = false
+ [Подняться в хранилище] -> storage_room
-
-> engine_exam

== stairs_room
VAR has_warm = false

Луч света из щели дверей хранилища освещает небольшую комнату. Сверху из лестничного пролета виден дневной свет. Здесь очень холодно.
- (stairs_exam)
* {not has_warm} [Подняться вверх]
    Если я попытаюсь выйти наружу в такую погоду, то неизбежно замерзну...
* {not has_warm && has_knife && has_cover} [Нарезать обшивку]
    Разрезав обшивку на куски, я затолкал их под одежду. Теперь будет намного теплее.
    Теперь, когда я утеплил свою одежду обшивкой, можно подняться вверх...
    ~ has_cover = false
    ~ has_warm = true
* {has_warm} [Подняться вверх] -> cutscene2
+ [Вернуться в хранилище] -> storage_room
-
-> stairs_exam

== cutscene2
>>> CLEAR
>>> IMG gfx/up.png
Я поднялся по лестнице и вошел в большой круглый зал. Тот самый, в котором нас провожали в долгий путь.
Зал был абсолютно пуст и, очевидно, давно заброшен. Всё, что представляло хоть малейшую ценность, растащили. Мозаика на стенах местами осыпалась, в потолке зияли дыры, через которые в зал проникал дневной свет.

* [...] -> hall_room

== hall_room
Я вышел из зала на круговую галерею. И был поражён увиденным.
За огромными окнами галереи открывался потрясающий вид. На холмах, слегка покрытых лесом, кое-где лежал снег. И там, среди холмов, до самого горизонта стояли огромные ветряки, их лопасти медленно вращались. А рядом сияли огни небольшого города.

- (hall_exam)
* [Посмотреть на ветряки]
    Я насчитал около десятка ветряков. Как будто картина из фантастического романа.
    - - (seen_mills)
* [Посмотреть на город]
    Город сильно изменился за эти годы. Появились новые кварталы со множеством высотных зданий.
    - - (seen_city)
* {seen_mills && seen_city} [Идти дальше] -> cutscene_end
-
-> hall_exam

== cutscene_end
>>> CLEAR
>>> IMG gfx/monument.png
Получасовой спуск оказался утомителен для меня, и я остановился отдохнуть возле поросшего травой монумента.
На вершине холма виднелось здание, в котором я провел столько лет. Но теперь причина, по которой оно оказалось заброшенным, больше меня не беспокоила - то, что я увидел сверху, давало мне надежду.

* [...] -> finale

== finale
>>> IMG gfx/finale.png
Надежду увидеть своими глазами то, ради чего проделал этот долгий и сложный путь.
* Будущее.
    * * Светлое будущее.
        * * * Светлое коммунистическое будущее.


-> DONE