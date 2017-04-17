// Copyright (c) 2017, amadison. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
  selector: 'dynamic-form',
  styleUrls: const ['dynamic_form.css'],
  templateUrl: 'dynamic_form.html',
  directives: const [materialDirectives, FORM_DIRECTIVES],
  providers: const [materialProviders],
)
class DynamicFormComponent implements OnInit {
  ControlGroup dynamicForm;
  FormBuilder _fb;
  // https://scotch.io/tutorials/how-to-build-nested-model-driven-forms-in-angular-2

  // looks like we'll be able to create a control for each field dynamically.
  Control firstName = new Control("", Validators.required);

  DynamicFormComponent(FormBuilder this._fb);

  @override
  ngOnInit() {
    dynamicForm = _fb.group({
      'name': firstName,
    });
  }

  void save(ControlGroup form) {
    if (form.valid) {
      print(new JsonEncoder.withIndent('  ').convert(form.value));
    } else {
      print("Form isn't valid");
      print(form.errors);
    }
  }
}



