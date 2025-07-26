import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:your_store_app/app/router/app_routes.dart';
import 'package:your_store_app/features/auth/models/user_model.dart';

import '../presenter/register_presenter.dart';
import '../presenter/register_event.dart';
import '../presenter/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final countryCtrl = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPassCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    cityCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, bottom: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.secondary.withValues(alpha: 0.5),
              colors.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: colors.surface.withValues(alpha: 0.95),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocConsumer<RegisterPresenter, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: colors.error,
                        ),
                      );
                    }
                    if (state is RegisterSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('¡Registro exitoso!', style: TextStyle(color: colors.surface)),
                          backgroundColor: colors.tertiaryContainer,
                        ),
                      );
                      context.pushReplacement(AppRoutes.home);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(Icons.person_add_alt_1, size: 72, color: colors.primary),
                          const SizedBox(height: 12),
                          Text(
                            'Crear cuenta',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge?.copyWith(color: colors.primary),
                          ),
                          const SizedBox(height: 24),
                          _buildTextField(firstNameCtrl, 'Nombre', Icons.person_outline, 'Ingrese su nombre'),
                          const SizedBox(height: 16),
                          _buildTextField(lastNameCtrl, 'Apellido', Icons.person_outline, 'Ingrese su apellido'),
                          const SizedBox(height: 16),
                          _buildEmailField(),
                          const SizedBox(height: 16),
                          _buildPhoneField(),
                          const SizedBox(height: 16),
                          _buildTextField(addressCtrl, 'Dirección', Icons.home_outlined, 'Ingrese su dirección'),
                          const SizedBox(height: 16),
                          _buildTextField(cityCtrl, 'Ciudad', Icons.location_city, 'Ingrese su ciudad'),
                          const SizedBox(height: 16),
                          _buildTextField(countryCtrl, 'País', Icons.flag_outlined, 'Ingrese su país'),
                          const SizedBox(height: 16),
                          _buildPasswordField(),
                          const SizedBox(height: 16),
                          _buildConfirmPasswordField(),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: state is RegisterLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<RegisterPresenter>().add(
                                              RegisterSubmitted(
                                                user: UserModel(
                                                  email: emailCtrl.text.trim(),
                                                  password: passwordCtrl.text.trim(),
                                                  firstName: firstNameCtrl.text.trim(),
                                                  lastName: lastNameCtrl.text.trim(),
                                                  phone: phoneCtrl.text.trim(),
                                                  address: addressCtrl.text.trim(),
                                                  city: cityCtrl.text.trim(),
                                                  country: countryCtrl.text.trim(),
                                                ),
                                              ),
                                            );
                                      }
                                    },
                              child: state is RegisterLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('Registrarse'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('¿Ya tienes cuenta? Inicia sesión', style: TextStyle(color: colors.primary)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String errorMsg) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colors.secondary),
      ),
      validator: (v) => v == null || v.isEmpty ? errorMsg : null,
    );
  }

  Widget _buildEmailField() {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: emailCtrl,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined, color: colors.secondary),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Ingrese su email';
        final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        if (!regex.hasMatch(v)) return 'Email inválido';
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: phoneCtrl,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Teléfono',
        prefixIcon: Icon(Icons.phone_outlined, color: colors.secondary),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Ingrese su número de teléfono';
        if (!RegExp(r'^[0-9]+$').hasMatch(v)) return 'Solo números';
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: passwordCtrl,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        prefixIcon: Icon(Icons.lock_outline, color: colors.secondary),
        suffixIcon: IconButton(
          icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility, color: colors.secondary),
          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
        ),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Ingrese su contraseña';
        if (v.length < 6) return 'Mínimo 6 caracteres';
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: confirmPassCtrl,
      obscureText: !_confirmPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Confirmar Contraseña',
        prefixIcon: Icon(Icons.lock_outline, color: colors.secondary),
        suffixIcon: IconButton(
          icon: Icon(_confirmPasswordVisible ? Icons.visibility_off : Icons.visibility, color: colors.secondary),
          onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
        ),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Confirme su contraseña';
        if (v != passwordCtrl.text) return 'Las contraseñas no coinciden';
        return null;
      },
    );
  }
}
