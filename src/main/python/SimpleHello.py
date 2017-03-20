
class SimpleHello(object):
    def sayHello(self, intValue=-1, stringValue=""):
        print (intValue, stringValue)
        return "SimpleHello Python class said: Receveid hello from java. stringValue = {0}".format(stringValue)
    class Java:
        implements = ["myscala.IHello"]

from py4j.clientserver import ClientServer, JavaParameters, PythonParameters
simple_hello = SimpleHello()
gateway = ClientServer(
    java_parameters=JavaParameters(),
    python_parameters=PythonParameters(),
    python_server_entry_point=simple_hello
)

#
# para fechar use  gateway.close()
#
