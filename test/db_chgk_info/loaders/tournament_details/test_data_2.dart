import 'package:what_when_where/db_chgk_info/models/question.dart';
import 'package:what_when_where/db_chgk_info/models/question_info.dart';
import 'package:what_when_where/db_chgk_info/models/tournament.dart';
import 'package:what_when_where/db_chgk_info/models/tour.dart';
import 'package:what_when_where/db_chgk_info/models/tour_info.dart';
import 'package:what_when_where/db_chgk_info/models/tournament_info.dart';

const tournamentInfo2 = TournamentInfo(
  id: '70656',
  id2: 'sls2018iii_u',
  title: r'''Студенческая Лига Сибири – 2018/19. III тур''',
  questionsCount: '0',
  toursCount: '1',
  description:
      r'''Редакторы благодарят за тестирование и ценные замечания Дмитрия Вавера, Алексея Малькова, Максима Мерзлякова, Татьяну Фёдорову, Ричарда Янкевича, команду «Маникюр для Нагльфара», а также Ярослава Косарева за моральную поддержку.''',
  url: r'''https://db.chgk.info/tour/70656''',
  editors:
      r'''Сергей Лобачёв (Нижний Новгород), Сергей Терентьев (Санкт-Петербург)''',
  createdAt: '2020-04-15',
  playedAt: '2018-12-25',
);

const tourInfo2 = TourInfo(
  id: '70656',
  title: r'''Студенческая Лига Сибири – 2018/19. III тур''',
  questionsCount: '0',
  description:
      r'''Редакторы благодарят за тестирование и ценные замечания Дмитрия Вавера, Алексея Малькова, Максима Мерзлякова, Татьяну Фёдорову, Ричарда Янкевича, команду «Маникюр для Нагльфара», а также Ярослава Косарева за моральную поддержку.''',
  url: r'''https://db.chgk.info/tour/70656''',
  editors:
      r'''Сергей Лобачёв (Нижний Новгород), Сергей Терентьев (Санкт-Петербург)''',
  createdAt: '2020-04-15',
  playedAt: '2018-12-25',
  tournamentInfo: tournamentInfo2,
);

const expectedTournamentDetails2 = Tournament(
  id: '70656',
  id2: 'sls2018iii_u',
  info: tournamentInfo2,
  tours: [
    Tour(
      id: '70656',
      info: tourInfo2,
      questions: [
        Question(
          id: '1197982',
          question:
              r'''Отмечая, что отец Жакли́н Ке́ннеди был успешным брокером, а отчим — и вовсе миллионером, автор одной статьи говорит, что в её случае АЛЬФА была ТАКОЙ. ТАКАЯ АЛЬФА подаётся к самому дорогому в мире мороженому. Напишите слова, заменённые словами «ТАКАЯ АЛЬФА».''',
          answer: r'''золотая ложка.''',
          authors: r'''Сергей Терентьев (Санкт-Петербург)''',
          passCriteria: r'''золотая ложечка.''',
          comments:
              r'''про людей, родившихся в богатой семье, говорят, что они родились с серебряной ложечкой во рту. В одной нью-йоркском ресторане подают мороженое, приготовленное из какао-бобов 28 редких сортов, стоимостью 25000$. Неудивительно, что к блюду подаётся золотая ложечка — не стальной же таким блюдом лакомиться.''',
          sources: r'''https://lenta.ru/articles/2018/10/04/30swomen/''',
          info: QuestionInfo(
            id: '1197982',
            number: '1',
            url: r'''https://db.chgk.info/question/70657/1''',
            tourInfo: tourInfo2,
          ),
        ),
        Question(
          id: '1197983',
          question:
              r'''В одном ролике, рассказывающем о НЁМ, говорится, что уже через десять лет человечество может стать узником гигантской тюрьмы. В качестве решения проблемы предлагается использовать лазеры или магниты. Назовите ЕГО двумя словами.''',
          answer: r'''космический мусор.''',
          authors: r'''Сергей Лобачёв (Нижний Новгород)''',
          comments:
              r'''согласно пессимистическому сценарию, космический мусор уже в самом ближайшем времени может существенно затруднить запуск космических кораблей.''',
          sources:
              r'''1. https://www.youtube.com // https://goo.gl/MHFCBm 2. https://ru.wikipedia.org/wiki/Космический_мусор''',
          info: QuestionInfo(
            id: '1197983',
            number: '2',
            url: r'''https://db.chgk.info/question/70657/2''',
            tourInfo: tourInfo2,
          ),
        ),
      ],
    ),
  ],
);

const tournamentDetailsApiResponse2 = r'''
<?xml version="1.0" encoding="UTF-8"?>
<tournament>
<Id>70656</Id>
<ParentId>0</ParentId>
<Title>Студенческая Лига Сибири – 2018/19. III тур</Title>
<Number/>
<TextId>sls2018iii_u</TextId>
<QuestionsNum>0</QuestionsNum>
<Complexity/>
<Type>Ч</Type>
<Copyright>
</Copyright>
<Info>Редакторы благодарят за тестирование и ценные замечания Дмитрия Вавера, Алексея Малькова, Максима Мерзлякова, Татьяну Фёдорову, Ричарда Янкевича, команду «Маникюр для Нагльфара», а также Ярослава Косарева за моральную поддержку.</Info>
<URL>
</URL>
<FileName>sls2018iii_u.txt</FileName>
<RatingId/>
<Editors>Сергей Лобачёв (Нижний Новгород), Сергей Терентьев (Санкт-Петербург)</Editors>
<EnteredBy>
</EnteredBy>
<LastUpdated>2020-04-15 10:43:01</LastUpdated>
<PlayedAt>2018-12-25</PlayedAt>
<PlayedAt2/>
<KandId/>
<CreatedAt>2020-04-15</CreatedAt>
<ParentTextId/>
<ProcessedBy>7773</ProcessedBy>
<ChildrenNum>1</ChildrenNum>
<question>
<QuestionId>1197982</QuestionId>
<ParentId>70657</ParentId>
<Number>1</Number>
<Type>Ч</Type>
<TypeNum>0</TypeNum>
<TextId>sls2018iii_u.1-1</TextId>
<Question>Отмечая, что отец Жакли́н Ке́ннеди был успешным брокером, а отчим — и вовсе миллионером, автор одной статьи говорит, что в её случае АЛЬФА была ТАКОЙ. ТАКАЯ АЛЬФА подаётся к самому дорогому в мире мороженому. Напишите слова, заменённые словами «ТАКАЯ АЛЬФА».</Question>
<Answer>золотая ложка.</Answer>
<PassCriteria>золотая ложечка.</PassCriteria>
<Authors>Сергей Терентьев (Санкт-Петербург)</Authors>
<Sources>https://lenta.ru/articles/2018/10/04/30swomen/</Sources>
<Comments>про людей, родившихся в богатой семье, говорят, что они родились с серебряной ложечкой во рту. В одной нью-йоркском ресторане подают мороженое, приготовленное из какао-бобов 28 редких сортов, стоимостью 25000$. Неудивительно, что к блюду подаётся золотая ложечка — не стальной же таким блюдом лакомиться.</Comments>
<Rating/>
<RatingNumber/>
<Complexity/>
<Topic/>
<ProcessedBySearch/>
<parent_text_id/>
<ParentTextId>sls2018iii_u.1</ParentTextId>
<Notices>
</Notices>
</question>
<question>
<QuestionId>1197983</QuestionId>
<ParentId>70657</ParentId>
<Number>2</Number>
<Type>Ч</Type>
<TypeNum>0</TypeNum>
<TextId>sls2018iii_u.1-2</TextId>
<Question>В одном ролике, рассказывающем о НЁМ, говорится, что уже через десять лет человечество может стать узником гигантской тюрьмы. В качестве решения проблемы предлагается использовать лазеры или магниты. Назовите ЕГО двумя словами.</Question>
<Answer>космический мусор.</Answer>
<PassCriteria>
</PassCriteria>
<Authors>Сергей Лобачёв (Нижний Новгород)</Authors>
<Sources>1. https://www.youtube.com // https://goo.gl/MHFCBm 2. https://ru.wikipedia.org/wiki/Космический_мусор</Sources>
<Comments>согласно пессимистическому сценарию, космический мусор уже в самом ближайшем времени может существенно затруднить запуск космических кораблей.</Comments>
<Rating/>
<RatingNumber/>
<Complexity/>
<Topic/>
<ProcessedBySearch/>
<parent_text_id/>
<ParentTextId>sls2018iii_u.1</ParentTextId>
<Notices>
</Notices>
</question>
</tournament>
''';