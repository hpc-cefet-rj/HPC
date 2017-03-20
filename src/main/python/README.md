# Bridge scala/python

Uma descrição de como funciona um exemplo simples pode ser vista em 
[https://www.py4j.org/advanced_topics.html#using-clientserver](https://www.py4j.org/advanced_topics.html#using-clientserver)

Devemos iniciar um processo Python via `PythonBridge.py` no host desejado e ele ficará ouvindo na porta 25.334 por
chamadas de callbacks. No lado do Java/Scala a porta default usada é a 25.333 


```bash
cd scala/spark/src/main/python
./PythonBridge.py
```

O a chamada do método `controlCommand("shutdown")` no objeto `connection: PythonConnection`  do lado Java/Scala
invoca o **Shutdown** no Servidor do py4j que roda no lado Python.

