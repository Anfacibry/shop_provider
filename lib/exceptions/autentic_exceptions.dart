class AutenticExceptions implements Exception {
  final String key;
  AutenticExceptions({required this.key});
  Map<String, String> erros = {
    "EMAIL_EXISTS": "O endereço de e-mail já está sendo usado por outra conta.",
    "OPERATION_NOT_ALLOWED":
        "O login por senha está desabilitado para este usuário.",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "Bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde.",
    "EMAIL_NOT_FOUND":
        "Não há registro de usuário correspondente a este usuário. O usuário pode ter sido excluído.",
    "INVALID_PASSWORD":
        "A senha é inválida. Por favor, verifique a senha digitada e tente novamente",
    "USER_DISABLED": "A conta de usuário foi desativada por um administrador.",
  };

  @override
  String toString() {
    return erros[key] ?? "Erro não identificado";
  }
}
