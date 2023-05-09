/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * See LICENSE.txt included in this distribution for the specific
 * language governing permissions and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at LICENSE.txt.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */

/*
 * Copyright (c) 2010, 2019, Oracle and/or its affiliates. All rights reserved.
 * Portions Copyright (c) 2011, Jens Elkner.
 * Portions Copyright (c) 2017, 2020, Chris Fraire <cfraire@me.com>.
 */
package org.opengrok.indexer.search;
import spoon.Launcher;
import spoon.reflect.CtModel;
import spoon.reflect.code.CtInvocation;
import spoon.reflect.declaration.CtClass;
import spoon.reflect.declaration.CtMethod;
import spoon.reflect.visitor.filter.TypeFilter;

import java.util.Map;
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;

public class JavaCallHierarchyAnalyzer implements CallHierarchyAnalyzer {

    @Override
    public Map<String, List<String>> getCallHierarchy(String sourceCode, String methodName) {
        Map<String, List<String>> callHierarchy = new HashMap<>();
        Launcher spoonLauncher = new Launcher();
        spoonLauncher.addInputResource(sourceCode);
        spoonLauncher.buildModel();

        CtModel model = spoonLauncher.getModel();
        List<CtMethod<?>> methods = model.getElements(new TypeFilter<>(CtMethod.class));

        CtMethod<?> targetMethod = findMethodByName(methods, methodName);
        if (targetMethod != null) {
            buildCallHierarchy(targetMethod, methods, callHierarchy);
        }

        return callHierarchy;
    }

    private CtMethod<?> findMethodByName(List<CtMethod<?>> methods, String methodName) {
        return methods.stream()
                .filter(method -> method.getSimpleName().equals(methodName))
                .findFirst()
                .orElse(null);
    }

    private void buildCallHierarchy(CtMethod<?> method, List<CtMethod<?>> allMethods, Map<String, List<String>> callHierarchy) {
        List<CtInvocation<?>> invocations = method.getElements(new TypeFilter<>(CtInvocation.class));

        for (CtInvocation<?> invocation : invocations) {
            CtMethod<?> calledMethod = findMethodByInvocation(allMethods, invocation);
            if (calledMethod != null) {
                String key = getQualifiedName(method);
                String value = getQualifiedName(calledMethod);

                callHierarchy.computeIfAbsent(key, k -> new ArrayList<>()).add(value);
                buildCallHierarchy(calledMethod, allMethods, callHierarchy);
            }
        }
    }

    private CtMethod<?> findMethodByInvocation(List<CtMethod<?>> allMethods, CtInvocation<?> invocation) {
        String calledMethodName = invocation.getExecutable().getSimpleName();
        CtClass<?> calledMethodClass = (CtClass<?>) invocation.getExecutable().getDeclaringType();

        for (CtMethod<?> method : allMethods) {
            if (method.getSimpleName().equals(calledMethodName) && method.getDeclaringType().equals(calledMethodClass)) {
                return method;
            }
        }

        return null;
    }

    private String getQualifiedName(CtMethod<?> method) {
        return method.getDeclaringType().getQualifiedName() + "." + method.getSimpleName();
    }
}
