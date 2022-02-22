let expression = "x^3 + 5x^5 + 7x -4 + 6x"
expression = expression.replace(/\s/g, '')


const deriveTerm = (term) => {
    const splitTerm = term.split("^")
    const splitCoeficient = splitTerm[0].split(/(?=[a-z])/)
    console.log('splitCoeficient', splitCoeficient)
    const newPower = Number(splitTerm[1]) - 1
    let constructTerm = Number(splitTerm[1])
    if (splitCoeficient.length > 1) {
        constructTerm = constructTerm * Number(splitCoeficient[0])
    }
    let newterm = String(constructTerm)
    if (newPower > 1) {
        newterm = newterm + splitCoeficient[1] + '^' + newPower
    }
    return newterm
}


const derive = (xpr) => {
    expLength = xpr.length
    let newXpr = ''
    let xprTerm = ''
    for (var i = 0; i < expLength; i++) {
        const val = xpr[i]
        if (val === "-" || val === "+") {
            if (xprTerm.includes('^')) {
                while (xprTerm.includes('^')) {
                    xprTerm = deriveTerm(xprTerm)
                }
            }
            newXpr = newXpr + val + xprTerm
            xprTerm = ""
        } else {
            xprTerm = xprTerm + val
        }

    }
    return newXpr
}


while (expression.includes('^')) {
    expression = derive(expression)
}

expression = expression.replace(/[a-z]/g, '')

console.log(expression)
console.log(eval(expression))
