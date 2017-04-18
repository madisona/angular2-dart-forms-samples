// Copyright (c) 2017, amadison. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';

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

  // in a form array, if we do this, it keeps the same values in all of them
  // which isn't what we want.
  Control streetAddress = new Control("", Validators.required);

  DynamicFormComponent(FormBuilder this._fb);

  @override
  ngOnInit() {
    document.title = 'awesome sauce form';
    // if we're starting with a model, I think we need to set the default
    // for these form controls. Either that or bind ngModel in our form.
    // not sure if one is preferred over the other
    dynamicForm = _fb.group({
      'name': ['Peggy Sue', Validators.required],
      'addresses': _fb.array([
        initAddress(),
      ])
    });
  }

  ControlGroup initAddress() {
    return _fb.group({
      "streetAddress": ['', Validators.required],
      "city": [''],
      "state": [''],
      "zipCode": [''],
    });
  }

  void addAddress() {
    ControlArray control = dynamicForm.controls['addresses'];
    control.push(initAddress());
  }

  void removeAddress(dynamic i) {
    ControlArray control = dynamicForm.controls['addresses'];
    control.removeAt(i);
  }

  void save(ControlGroup form) {
    if (form.valid) {
      print(new JsonEncoder.withIndent('  ').convert(form.value));
    } else {
      print("Form isn't valid");
      print(form.errors);
    }
  }

  String get debug {
    return new JsonEncoder.withIndent('  ').convert(dynamicForm.value);
  }
}
