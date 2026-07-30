/*
 * Pipeline parameters
 */

 params.greeting = 'Hola mundo!'

process sayHello {

    publishDir 'results', mode: 'copy'

    input: 
        val greeting

    output:
        path 'output.txt'

    script:
    """
    echo '$greeting' > output.txt
    """
}

workflow {

    // emit a greeting
    sayHello(params.greeting)
}