import 'dart:math';
import 'package:hive_flutter/adapters.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/notification.dart';

class Quotes {
  static Future<void> set() async {
    var user = Hive.box('userBox');

    final _random = new Random();

    Map<String, String> quote = Quotes.motivationalQuotes[
        _random.nextInt(Quotes.motivationalQuotes.length - 2)];

    user.put('quote', quote);
    // var res= HiveF
  }

  static List<Map<String, String>> motivationalQuotes = [
    {
      "quote": "Don't watch the clock; do what it does. Keep going.",
      "author": "Sam Levenson"
    },
    {
      "quote":
          "Success is the sum of small efforts, repeated day in and day out.",
      "author": "Robert Collier"
    },
    {
      "quote":
          "The secret of success is to do the common things uncommonly well.",
      "author": "John D. Rockefeller"
    },
    {
      "quote":
          "You don’t have to be great to start, but you have to start to be great.",
      "author": "Zig Ziglar"
    },
    {
      "quote": "Start where you are. Use what you have. Do what you can.",
      "author": "Arthur Ashe"
    },
    {
      "quote": "The best way to predict your future is to create it.",
      "author": "Abraham Lincoln"
    },
    {
      "quote": "Believe you can and you're halfway there.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote": "The expert in anything was once a beginner.",
      "author": "Helen Hayes"
    },
    {
      "quote": "The way to get started is to quit talking and begin doing.",
      "author": "Walt Disney"
    },
    {
      "quote": "Failure is the opportunity to begin again more intelligently.",
      "author": "Henry Ford"
    },
    {
      "quote":
          "The mind is not a vessel to be filled, but a fire to be ignited.",
      "author": "Plutarch"
    },
    {
      "quote":
          "Education is the passport to the future, for tomorrow belongs to those who prepare for it today.",
      "author": "Malcolm X"
    },
    {
      "quote":
          "The beautiful thing about learning is that no one can take it away from you.",
      "author": "B.B. King"
    },
    {
      "quote": "A year from now you may wish you had started today.",
      "author": "Karen Lamb"
    },
    {
      "quote":
          "The best time to plant a tree was 20 years ago. The second best time is now.",
      "author": "Chinese Proverb"
    },
    {
      "quote":
          "Your positive action combined with positive thinking results in success.",
      "author": "Shiv Khera"
    },
    {
      "quote":
          "It’s not whether you get knocked down; it’s whether you get up.",
      "author": "Vince Lombardi"
    },
    {
      "quote": "Don’t let what you cannot do interfere with what you can do.",
      "author": "John Wooden"
    },
    {
      "quote":
          "You are never too old to set another goal or to dream a new dream.",
      "author": "C.S. Lewis"
    },
    {
      "quote": "It always seems impossible until it's done.",
      "author": "Nelson Mandela"
    },
    {
      "quote": "Success doesn't come to you, you’ve got to go to it.",
      "author": "Marva Collins"
    },
    {
      "quote":
          "The will to succeed is important, but what's more important is the will to prepare.",
      "author": "Bobby Knight"
    },
    {"quote": "Dreams don’t work unless you do.", "author": "John C. Maxwell"},
    {
      "quote":
          "The only place where success comes before work is in the dictionary.",
      "author": "Vidal Sassoon"
    },
    {
      "quote":
          "Challenges are what make life interesting and overcoming them is what makes life meaningful.",
      "author": "Joshua J. Marine"
    },
    {
      "quote":
          "Be not afraid of going slowly; be afraid only of standing still.",
      "author": "Chinese Proverb"
    },
    {
      "quote":
          "You don’t drown by falling in the water; you drown by staying there.",
      "author": "Ed Cole"
    },
    {
      "quote": "Procrastination makes easy things hard and hard things harder.",
      "author": "Mason Cooley"
    },
    {
      "quote":
          "You are braver than you believe, stronger than you seem, and smarter than you think.",
      "author": "A.A. Milne"
    },
    {
      "quote":
          "The only limit to our realization of tomorrow will be our doubts of today.",
      "author": "Franklin D. Roosevelt"
    },
    {
      "quote":
          "Do not wait to strike till the iron is hot; but make it hot by striking.",
      "author": "William Butler Yeats"
    },
    {
      "quote":
          "Motivation is what gets you started. Habit is what keeps you going.",
      "author": "Jim Rohn"
    },
    {
      "quote":
          "A river cuts through rock, not because of its power, but because of its persistence.",
      "author": "Jim Watkins"
    },
    {
      "quote":
          "Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time.",
      "author": "Thomas A. Edison"
    },
    {
      "quote":
          "Learning is like rowing upstream, not to advance is to drop back.",
      "author": "Chinese Proverb"
    },
    {
      "quote": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs"
    },
    {
      "quote":
          "Success is walking from failure to failure with no loss of enthusiasm.",
      "author": "Winston Churchill"
    },
    {
      "quote": "Opportunities don't happen, you create them.",
      "author": "Chris Grosser"
    },
    {
      "quote": "I find that the harder I work, the more luck I seem to have.",
      "author": "Thomas Jefferson"
    },
    {
      "quote":
          "The only difference between a good day and a bad day is your attitude.",
      "author": "Dennis S. Brown"
    },
    {
      "quote":
          "Success is not final, failure is not fatal: It is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
    {
      "quote":
          "Learn as if you will live forever, live like you will die tomorrow.",
      "author": "Mahatma Gandhi"
    },
    {
      "quote": "The best preparation for tomorrow is doing your best today.",
      "author": "H. Jackson Brown Jr."
    },
    {
      "quote":
          "Things work out best for those who make the best of how things work out.",
      "author": "John Wooden"
    },
    {
      "quote":
          "To be successful, you must accept all challenges that come your way. You can't just accept the ones you like.",
      "author": "Mike Gafka"
    },
    {"quote": "Be so good they can't ignore you.", "author": "Steve Martin"},
    {
      "quote": "The harder the battle, the sweeter the victory.",
      "author": "Les Brown"
    },
    {
      "quote": "Don’t let yesterday take up too much of today.",
      "author": "Will Rogers"
    },
    {
      "quote": "There are no shortcuts to any place worth going.",
      "author": "Beverly Sills"
    },
    {
      "quote":
          "Try not to become a person of success, but rather try to become a person of value.",
      "author": "Albert Einstein"
    },
    {
      "quote":
          "Don’t let the fear of losing be greater than the excitement of winning.",
      "author": "Robert Kiyosaki"
    },
    {
      "quote":
          "Our greatest fear should not be of failure but of succeeding at things in life that don't really matter.",
      "author": "Francis Chan"
    },
    {
      "quote":
          "If you genuinely want something, don't wait for it—teach yourself to be impatient.",
      "author": "Gurbaksh Chahal"
    },
    {
      "quote": "We may encounter many defeats but we must not be defeated.",
      "author": "Maya Angelou"
    },
    {
      "quote": "It's not about perfect. It's about effort.",
      "author": "Jillian Michaels"
    },
    {
      "quote": "You just can't beat the person who never gives up.",
      "author": "Babe Ruth"
    },
    {
      "quote":
          "The only way to achieve the impossible is to believe it is possible.",
      "author": "Charles Kingsleigh"
    },
    {
      "quote": "You must do the thing you think you cannot do.",
      "author": "Eleanor Roosevelt"
    },
    {
      "quote":
          "If it's important to you, you'll find a way. If not, you'll find an excuse.",
      "author": "Ryan Blair"
    },
    {
      "quote":
          "Success is the progressive realization of a worthy goal or ideal.",
      "author": "Earl Nightingale"
    },
    {
      "quote": "Doubt kills more dreams than failure ever will.",
      "author": "Suzy Kassem"
    },
    {"quote": "Make each day your masterpiece.", "author": "John Wooden"},
    {
      "quote":
          "The difference between a successful person and others is not a lack of strength, not a lack of knowledge, but rather a lack in will.",
      "author": "Vince Lombardi"
    },
    {
      "quote":
          "Courage is resistance to fear, mastery of fear—not absence of fear.",
      "author": "Mark Twain"
    },
    {
      "quote": "Success is where preparation and opportunity meet.",
      "author": "Bobby Unser"
    },
    {
      "quote":
          "Focus on the journey, not the destination. Joy is found not in finishing an activity but in doing it.",
      "author": "Greg Anderson"
    },
    {
      "quote": "Aim for the moon. If you miss, you may hit a star.",
      "author": "W. Clement Stone"
    },
    {
      "quote":
          "You can't go back and change the beginning, but you can start where you are and change the ending.",
      "author": "C.S. Lewis"
    },
    {
      "quote":
          "The function of leadership is to produce more leaders, not more followers.",
      "author": "Ralph Nader"
    },
    {
      "quote":
          "The future belongs to those who believe in the beauty of their dreams.",
      "author": "Eleanor Roosevelt"
    },
    {"quote": "You have to be odd to be number one.", "author": "Dr. Seuss"},
    {
      "quote": "The best revenge is massive success.",
      "author": "Frank Sinatra"
    },
    {
      "quote":
          "Your time is limited, don't waste it living someone else's life.",
      "author": "Steve Jobs"
    },
    {
      "quote":
          "The only way to achieve the impossible is to believe it is possible.",
      "author": "Alice in Wonderland"
    },
    {
      "quote":
          "The only limit to our realization of tomorrow is our doubts of today.",
      "author": "Franklin D. Roosevelt"
    },
    {
      "quote": "Dream big and dare to fail.",
      "author": "Norman Vaughan",
    },
    {
      "quote":
          "What you lack in talent can be made up with desire, hustle and giving 110% all the time.",
      "author": "Don Zimmer"
    }
  ];
}
