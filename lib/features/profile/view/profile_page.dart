import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/core/db/drift/app_database.dart';
import 'package:your_store_app/features/auth/models/user_model.dart';
import 'package:your_store_app/features/profile/presenter/events/profile_event.dart';
import 'package:your_store_app/features/profile/presenter/profile_presenter.dart';
import 'package:your_store_app/features/profile/presenter/states/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final countryCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfilePresenter>().add(const ProfileStarted());
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    cityCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }

  void _fillControllers(User user) {
    firstNameCtrl.text = user.firstName;
    lastNameCtrl.text = user.lastName;
    emailCtrl.text = user.email;
    phoneCtrl.text = user.phone ?? '';
    addressCtrl.text = user.address ?? '';
    cityCtrl.text = user.city ?? '';
    countryCtrl.text = user.country ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: BlocConsumer<ProfilePresenter, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            _fillControllers(state.user);
          }
          if (state is ProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colors.tertiaryContainer,
              ),
            );
          }
          if (state is ProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded || state is ProfileSuccess) {
          // Para simplificar, usar el último user disponible
            final user = (state is ProfileLoaded) ? state.user : (state as ProfileSuccess).user;
            final saving = (state is ProfileLoaded) ? state.saving : false;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AbsorbPointer(
                absorbing: saving,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _AvatarHeader(user: user),
                      const SizedBox(height: 24),

                      TextFormField(
                        controller: firstNameCtrl,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        validator: (v) => v == null || v.isEmpty ? 'Ingrese su nombre' : null,
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: lastNameCtrl,
                        decoration: const InputDecoration(labelText: 'Apellido'),
                        validator: (v) => v == null || v.isEmpty ? 'Ingrese su apellido' : null,
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Ingrese su email';
                          final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                          if (!regex.hasMatch(v)) return 'Email inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(labelText: 'Teléfono'),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: addressCtrl,
                        decoration: const InputDecoration(labelText: 'Dirección'),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: cityCtrl,
                        decoration: const InputDecoration(labelText: 'Ciudad'),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: countryCtrl,
                        decoration: const InputDecoration(labelText: 'País'),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: saving
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    final model = UserModel(
                                      id: user.id,
                                      firstName: firstNameCtrl.text.trim(),
                                      lastName: lastNameCtrl.text.trim(),
                                      email: emailCtrl.text.trim(),
                                      phone: phoneCtrl.text.trim().isEmpty ? null : phoneCtrl.text.trim(),
                                      address: addressCtrl.text.trim().isEmpty ? null : addressCtrl.text.trim(),
                                      city: cityCtrl.text.trim().isEmpty ? null : cityCtrl.text.trim(),
                                      country: countryCtrl.text.trim().isEmpty ? null : countryCtrl.text.trim(),
                                    );

                                    context.read<ProfilePresenter>().add(ProfileSubmitted(model));
                                  }
                                },
                          child: saving
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Guardar cambios'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is ProfileFailure) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _AvatarHeader extends StatelessWidget {
  final User user;
  const _AvatarHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: colors.primary.withValues(alpha: 0.1),
          child: Text(
            user.firstName.isNotEmpty ? user.firstName[0].toUpperCase() : '?',
            style: TextStyle(
              fontSize: 32,
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${user.firstName} ${user.lastName}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.tertiary,
              ),
        ),
      ],
    );
  }
}
