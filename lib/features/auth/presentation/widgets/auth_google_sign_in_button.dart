import 'package:flutter/material.dart';

class AuthGoogleSignInButton extends StatelessWidget {
  const AuthGoogleSignInButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool loading;

  static const _gBlue = Color(0xFF4285F4);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: loading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.65)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: scheme.primary,
                ),
              )
            else
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: scheme.outline.withValues(alpha: 0.4)),
                ),
                child: const Text(
                  'G',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _gBlue,
                  ),
                ),
              ),
            if (!loading) const SizedBox(width: 12),
            if (loading) const SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}
