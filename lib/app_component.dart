// Copyright (c) 2017, amadison. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:angular2_components/angular2_components.dart';

import 'hello_dialog/dynamic_form.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  viewBindings: const [FORM_BINDINGS],
  directives: const [materialDirectives, DynamicFormComponent, FORM_DIRECTIVES],
  providers: const [materialProviders],
)
class AppComponent {

  Map formStuff = {
//    'name': 'Aaron',
  };

  ControlGroup sampleForm;
  // can use Validators.compose to run multiple validators and return the union of their errors
  AppComponent(FormBuilder builder) {
    // the first argument on these is a default value...

    this.sampleForm = builder.group({
      'name': ['', Validators.required],
      'phone': ['', Validators.pattern(r"\d{3}\-\d{3}\-\d{4}")],
      'loginForm': builder.group({
        'username': ['', Validators.compose([Validators.required, Validators.maxLength(50)])],
        'password': ['', Validators.compose([Validators.required, Validators.minLength(8)])]
      })
    });
  }

  String get value {
//    return JSON.encode(this.sampleForm.value);
    return new JsonEncoder.withIndent('  ').convert(this.sampleForm.value);
  }
}
