polynomialDerivative() {
  var expression = "x^3 + 5x^5 + 7x -4 + 6x";

  var polynomial = expression.replaceAll(RegExp(r'\s'), '');

  deriveTerm(var term) {
    final splitTerm = term.split("^");
    final splitCoeficient = splitTerm[0].split(RegExp(r'(?=[a-z])'));
    print('splitCoeficient $splitCoeficient');
    final newPower = (splitTerm[1]) - 1;
    var constructTerm = (splitTerm[1]);
    if (splitCoeficient.length > 1) {
      constructTerm = constructTerm * (splitCoeficient[0]);
    }
    var newterm = constructTerm.toString();
    if (newPower > 1) {
      newterm = '$newterm ${splitCoeficient[1]} ^ $newPower';
    }
    return newterm;
  }

  derive(var exp) {
    var expLength = exp.length;
    var newExp = '';
    var expTerm = '';
    for (var i = 0; i < expLength; i++) {
      final val = exp[i];
      if (val == "-" || val == "+") {
        if (expTerm.contains('^')) {
          while (expTerm.contains('^')) {
            expTerm = deriveTerm(expTerm);
          }
        }
        newExp = newExp + val + expTerm;
        expTerm = "";
      } else {
        expTerm = expTerm + val;
      }
    }
    return newExp;
  }

  while (polynomial.contains('^')) {
    polynomial = derive(polynomial);

    polynomial = polynomial.replaceAll(RegExp(r'\s'), '');
    print(polynomial);
  }
}

void main() {
  polynomialDerivative();
}
