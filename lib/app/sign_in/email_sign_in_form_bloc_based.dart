import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:timetracker/widgets/form_submit_button.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/services/auth.dart';
import 'package:flutter/services.dart';

import 'package:timetracker/widgets/platform_exception_alert_dialog.dart';

import 'email_sign_in_model.dart';


//stateful widget is used as we need to change some values of the variables

class EmailSignInFormBlockBased extends StatefulWidget {

  EmailSignInFormBlockBased({this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context,listen: false);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth) ,
      child: Consumer<EmailSignInBloc>(
        builder: (context,bloc,_) => EmailSignInFormBlockBased(bloc: bloc,),

      ),
      dispose: (context,bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlockBasedState createState() => _EmailSignInFormBlockBasedState();
}

class _EmailSignInFormBlockBasedState extends State<EmailSignInFormBlockBased> {
  //EmailSignInFormType _formType = EmailSignInFormType.signIn;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();



  //The dispose method is called each time a widget is disposed or poped in navigator
  // it removes the items which no longer needed when widget is removed
  //it is important to dispose the controllers , focus node
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  Future<void> _submit() async {

    try {
      await widget.bloc.submit();
     Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in Failed',
        exception:e,
      ).show(context);
    }
  }

  void _toggleFormType() {
   widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  //To change the focus when next button in keyboard while on username is clicked
  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(model),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(
        height: 4.0,
      ),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: !model.isLoading ? _toggleFormType : null,
      )
    ];
  }

//Email Method
  TextField _buildEmailTextField(EmailSignInModel model) {
      return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText: model.emailErrorText,
          enabled: model.isLoading == false),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete:() => _emailEditingComplete(model),
      onChanged: widget.bloc.updateEmail,
    );
  }

  //Password Method

  TextField _buildPasswordTextField(EmailSignInModel model) {

    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      textInputAction: TextInputAction.done,
      obscureText: true,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
      onChanged:widget.bloc.updatePassword,
    );
  }

  // this is going to execute first
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(model),
          ),
        );
      }
    );
  }


}
