#!/usr/bin/env python
# -*- coding: utf-8 -*-

shutdownRequested = False
class PythonBridgePyImpl(object):
    def controlCommand(self, cmd="shutdown"):
        print (cmd, " Requested")
        global shutdownRequested
        shutdownRequested = True
        return "»»»»»» PythonBridgePyImpl Python class said: Receveid controlCommand. Command {0} requested".format(cmd)
    def loadUDF(self, udfLibraryFileName= "/desenv/lib01.py", expr=""):
        print (udfLibraryFileName, expr)
        execfile(udfLibraryFileName)
        return "»»»»»» PythonBridgePyImpl Python class said: Receveid loadUDF request from java. udfLibraryFileName = {0}, expr = {1}".format(udfLibraryFileName, expr)
    def eval(self, expr=""):
        print (expr)
        return "»»»»»» PythonBridgePyImpl Python class said: Receveid eval request from java. expr = {0}".format(expr)
    class Java:
        implements = ["myscala.wfw.PythonBridge"]

from py4j.clientserver import ClientServer, JavaParameters, PythonParameters
pythonBridge = PythonBridgePyImpl()
gateway = ClientServer(
    java_parameters=JavaParameters(),
    python_parameters=PythonParameters(),
    python_server_entry_point=pythonBridge
)

import time
mins = 0
while shutdownRequested != True:
    print "[", mins, "] status: running ..."
    # Sleep for a minute
    time.sleep(60)
    # Increment the minute total
    mins += 1

gateway.close()

#
# para fechar use  gateway.close()
#
