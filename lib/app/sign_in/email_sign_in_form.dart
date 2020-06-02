import 'package:flutter/material.dart';
import 'package:timetracker/services/auth.dart';
import 'package:timetracker/widgets/form_submit_button.dart';
import 'package:timetracker/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }


//stateful widget is used as we need to change some values of the variables

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({@required this.auth});

  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // to get email and password
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  //To display error text only after submitting the form
  bool _submitted = false;
  // this is to prevent user from submitting frequent or cont sign in , as it need time to register
  bool _isLoading = false;


  void _submit() async {
    setState(() {
      _submitted=true;
      _isLoading=true;
    });
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }finally{
      setState(() {
        _isLoading=false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
      _submitted=false;
    });
  }

  //To change the focus when next button in keyboard while on username is clicked
  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email) ?
    _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an Account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an Account?Register!'
        : 'Have an Account? Sign in ';

    // this is to not to enable submit button is email and password is empty and also when we are not in the loading state
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) && !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 4.0,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      )
    ];
  }

//Email Method
  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText: showErrorText ? widget.invalidEmailErrorText : null,
      enabled: _isLoading == false),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (_email) => _updateState(),
    );
  }

  //Password Method

  TextField _buildPasswordTextField() {

    bool showErrorText = _submitted  &&  !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      textInputAction: TextInputAction.done,
      obscureText: true,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
      onChanged: (_password) => _updateState(),
    );
  }


  // this is going to execute first
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
