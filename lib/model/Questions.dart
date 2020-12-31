class Questions {
  static final COLD_FLU_QUESTIONS = const [
    {
      'questionText': 'Q1. Have you had fever during cold?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -5},
      ],
    },
    {
      'questionText': 'Q2. Did you feel difficulty in breathing?',
      'answers': [
        {
          'text': 'Yes',
          'score': 5,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': ' Q3.Did you feel chest pain / pressure?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Did you feel muscle pain?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q5. Have you had watery eyes?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q6. Have you had runny nose?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q7. Have you had headache or body ache?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q8. Did you feel loss of appetite?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q9. Have you had sore throat?',
      'answers': [
        {
          'text': 'Yes',
          'score': 10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
  ];

  static final ALLERGIES_QUESTIONS = const [
    {
      'questionText': 'Q1. Have you had Asthma (Wheezing)?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q2. Have you had any Other Breathing Problems?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q3. Have you had sinus Trouble?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText':
          'Q4. Have you had hay Fever (runny, stuffy, itchy nose; sneezing)? ',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q5. Have you had hives or Swelling? ',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q6. Have you had frequent Infections?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q7. Have you had food Reactions?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q8. Have you had drug Reactions?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q9. Do you smoke?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q10. Does anyone around you smoke?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q11. Have you had loss of taste?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q12. Are you excessively nervous?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q13. Do you have pets?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q14. Have you had loss of smell?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q15. Have you had shortness of breath?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];

  static final CARDIO_VASCULAR_QUESTIONS = const [
    {
      'questionText':
          'Q1. Do you feel pain or pressure in the chest, which may indicate angina?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q2. Do you feel pain or discomfort in the arms, left shoulder, elbows, jaw, or back?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q3. Do you suffer with the shortness of breath issue?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Have you lightheadedness or dizziness?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q5. Are you facing cold sweats?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q6. Do you have high cholesterol?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q7. Have high blood pressure problem?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q8. Have poor sleep hygiene?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText': 'Q9. Do you have smoking habbit?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
  ];
  static final HAIR_FALL = const [
    {
      'questionText':
          "Q1. Do you have a family history of balding on your mother's or father's side?",
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': -10},
      ],
    },
    {
      'questionText': "Q2. In which age do you fall?",
      'answers': [
        {
          'text': 'Less than 40',
          'score': -2,
        },
        {'text': 'Above 40', 'score': 10},
      ],
    },
    {
      'questionText': "Q3. Are you following some weight loss diet",
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': -2},
        {'text': 'Not very often', 'score': 10},
      ],
    },
    {
      'questionText':
          "Q4. Facing certain medical conditions, such as diabetes and lupus?",
      'answers': [
        {
          'text': 'Yes',
          'score': -10,
        },
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText':
          "Q5. 	Having some Stress?",
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText':
          "Q6.  Are you taking proper intake of good nutrients?",
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },

        {'text': 'No', 'score': -2},
        {'text': 'Not very often', 'score': 10},
      ],
    },
    {
      'questionText':
          "Q7. Hair falling out in clumps or patches?",
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
    {
      'questionText':
          "Q8. Is there Thinning of hair?",
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText':
          "Q9. Having some medications i.e.",
      'answers': [
        {
          'text': 'Blood thinners such as warfarin',
          'score': -2,
        },
        {'text': 'Accutane, to treat acne', 'score': 10},
        {'text': 'Antidepressants', 'score': -2},
        {'text': 'Beta-blockers', 'score': -2},
        {'text': 'Cholesterol lowering drugs, lopid', 'score': -2},
      ],
    },
    {
      'questionText':
          "Q10. Intake of vitamin D on regular basis?",
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'Not very often', 'score': 10},
        {'text': 'No', 'score': -2},
      ],
    },
  ];
  static final DIABETICS = const [
    {
      'questionText': 'Q1. I am unable to do household chores?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q2. I have missed work due to diabetes?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': ' Q3.I am unable to go up and down stairs?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q4. I have cut back on social functions (hobbies, church, and clubs)?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q5. I have trouble with my energy level?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q6. I have concerns about my sexual function?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q7. I have trouble with sleep?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q8. I have trouble affording my medications?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q9. I have trouble with concentration?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q10. I have trouble managing my medications?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q11. I am thirsty and drink a lot?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q12. I lose control of my urine and get wet?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q13.I urinate a lot?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q14.I have been down, depressed and hopeless lately?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q15.I have lost interest in, or no longer enjoy the things I used to enjoy doing?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Q16.Have you had 5 or more drinks at one occasion in the last 3 months?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];

  static final HEADACHE = const[

    {
      'questionText': 'Q1.How much sleep did you get in last 24 hours?',
      'answers': [
        {
          'text': 'Less than 3 hours',
          'score': -2,
        },
        {'text': '3-6 Hours', 'score': 10},
        {'text': 'More than 6 hours', 'score': 10},
      ],
    },
    {
      'questionText': 'Q2.What did you eat in your last meal?',
      'answers': [
        {
          'text': 'Homemade food',
          'score': -2,
        },
        {'text': 'Fast food', 'score': 10},
        {'text': 'Spicy/oily food from restaurant', 'score': 10},
      ],
    },
    {
      'questionText': 'Q3.Are you stressed?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},

      ],
    },
    {
      'questionText': 'Q4.Have you been working/sitting in front of your screen for a long time?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},

      ],
    },
    {
      'questionText': 'Q5.How severe is the headache?',
      'answers': [
        {
          'text': 'Mild',
          'score': -2,
        },
        {'text': 'Severe', 'score': 10},
        {'text': 'Moderate', 'score': 10},
        {'text': 'Worst ever', 'score': 10},

      ],
    },
    {
      'questionText': 'Q6.Does the headache get worse with any of these?',
      'answers': [
        {
          'text': 'Skipping meals',
          'score': -2,
        },

        {'text': 'Psychological stress', 'score': 10},
        {'text': 'Exercise', 'score': -5},
        {'text': 'Sneeze or cough', 'score': -5},
        {'text': 'Change in sleep pattern', 'score': 10},

      ],
    },
    {
      'questionText': 'Q7.How did the headache appear?',
      'answers': [
        {
          'text': 'Sudden',
          'score': -2,
        },
        {'text': 'Gradual', 'score': 10},

      ],
    },
    {
      'questionText': 'Q8.Does it get better with any of the following?',
      'answers': [
        {
          'text': 'Sleep',
          'score': -2,
        },
        {'text': 'Stress management', 'score': 10},

      ],
    },

  ];

  static final STOMACHACHE = [
    {
      'questionText': 'Q1.Are you facing any of these?',
      'answers': [
        {
          'text': 'Vomiting',
          'score': -2,
        },
        {'text': 'Nausea', 'score': 10},
        {'text': '	Reduced appetitie', 'score': 10},
        {'text': 'Fatigue', 'score': 10},
        {'text': 'Stomach cramps', 'score': 10},
        {'text': 'Diarrhea', 'score': 10},
        {'text': 'Bloating', 'score': 10},
        {'text': 'Fever', 'score': 10},
      ],
    },
    {
      'questionText': 'Q2.How did it appear?',
      'answers': [
        {
          'text': 'Sudden',
          'score': -2,
        },
        {'text': 'Gradual', 'score': 10},

      ],
    },
    {
      'questionText': 'Q3.How long have you had this problem?',
      'answers': [
        {
          'text': 'Less than week',
          'score': -2,
        },
        {'text': '2-3 weeks', 'score': 10},
        {'text': 'More than 3 weeks', 'score': 10},
      ],
    },
    {
      'questionText': 'Q4.How much sleep did you get?',
      'answers': [
        {
          'text': 'Less than 3 hours',
          'score': -2,
        },
        {'text': '3-6 Hours', 'score': 10},
        {'text': 'More than 6 hours', 'score': 10},


      ],
    },
    {
      'questionText': 'Q5.Does it get worse when you eat?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},

      ],
    },
    {
      'questionText': 'Q6.How severe is the pain?',
      'answers': [
        {
          'text': 'Mild',
          'score': -2,
        },
        {'text': 'Severe', 'score': 10},
        {'text': 'Moderate', 'score': 10},
        {'text': 'Worst ever', 'score': 10},

      ],
    },
    {
      'questionText': 'Q7.How would you explain this pain?',
      'answers': [
        {
          'text': 'Throbbing sensation',
          'score': -2,
        },

        {'text': 'Burning sensation', 'score': 10},
        {'text': 'Sensation of tearing pain', 'score': -5},

      ],
    },



  ];
// Question
// options
// [
//   {
//
// }
// ]
}
