// Copyright (c) 2017, amadison. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

// should some of this be a list or just a Map with an ordered property?
// todo: eventually this should be represented in classes / models
// would be nice to be able to have a list of set validators?
// validators could define both validation rule and error message
List configDefinition = [
  {
    'name': 'pay_plan',
    'description': 'Pay Plan',
    'required': true,
    'default': 'annual',
    'type': 'select',
    'choices': [
      ['annual', 'Annual'],
      ['semi-annual', 'Semi-Annual'],
      ['quarterly', 'Quarterly'],
      ['monthly', 'Monthly'],
    ],
  },
  {
    'name': 'peril',
    'description': 'Peril Group',
    'required': true,
    'default': '',
    'type': 'select',
    'choices': [
      ['', '--- peril group ---'],
      ['basic', 'Basic Form'],
      ['broad', 'Broad Form'],
      ['special', 'Special Form'],
    ],
  },
  {
    'name': 'effective_date',
    'description': 'Effective Date',
    'required': true,
    'type': 'text',
    'help_text': "mm/dd/YYYY"
  },
  {
    'name': 'applicant',
    'description': 'Applicant Name',
    'required': true,
    'type': 'text',
    'help_text': "Please enter applicant's name"
  },
  {
    'name': 'applicant_type',
    'description': 'Applicant Type',
    'required': true,
    'default': 'primary',
    'type': 'select',
    'choices': [
      ['primary', 'Primary'],
      ['secondary', 'Secondary'],
      ['college', 'College Friend'],
    ],
  },

  {
    'name': 'dob',
    'description': 'Date of Birth',
    'required': false,
    'type': 'text',
    // how would we tell it to validate a date or restrict dates?
    'help_text': "mm/dd/YYYY",
  },
];

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, FORM_DIRECTIVES],
  providers: const [materialProviders],
)
class AppComponent {

  ControlGroup sampleForm;
  List config = configDefinition;
  // can use Validators.compose to run multiple validators and return the union of their errors
  // instead of necessarily how we have default right now, we could put something like
  // model.name in there and it might update the model accordingly?
  AppComponent(FormBuilder builder) {

    Map controlBuilder = {};
    config.forEach((field) {
      var validators = [];
      if (field['required'] == true) {
        validators.add(Validators.required);
      }

      var default_val = field['default'] ?? "";
      controlBuilder[field['name']] = [default_val, Validators.compose(validators)];

    });
    sampleForm = builder.group(controlBuilder, {
      'validator': sampleGroupValidator,
    });
  }

  String get debug {
    return new JsonEncoder.withIndent('  ').convert(this.sampleForm.value);
  }

  // this is how you can make a custom field validator
  // control.value is the whole structure on a group validator.
  static Map<String, bool> sampleGroupValidator(AbstractControl control) {
    // this wouldn't be a very efficient cross field validation if we hit
    // an external api to validate because every keystroke change this re-evaluates.
    return control.value['applicant'] == "alm"
        ? null
        : {"bananas": true};
  }

  void submitForm() {
    print("Form Submitted");
    print(this.sampleForm.value);
  }
}
