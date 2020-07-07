//
//  ObjcRuntime.m
//  ParentalControls_iOS
//
//  Created by ap106875 on 2016/12/3.
//  Copyright © 2016年 studyos. All rights reserved.
//

#import "ObjcRuntime.h"
#import <objc/runtime.h>

// 如果是类方法则交换类方法 如果是实例方法 则交换实例方法
void Swizzle(Class c, SEL origSEL, SEL newSEL) {
    Method origMethed = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if(!origSEL) {
        origMethed = class_getClassMethod(c, origSEL);
        if(!origMethed) {
            return;
        }
        newMethod = class_getClassMethod(c, newSEL);
        if(!newMethod) {
            return;
        }
    }
    else {
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }
    
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, newSEL, method_getImplementation(origMethed), method_getTypeEncoding(origMethed));
    }
    else {
        method_exchangeImplementations(newMethod, origMethed);
    }
}

void SwizzleInstance(Class c,SEL origSEL, SEL newSEL) {
    Method origMethed = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if(!origSEL) {
        origMethed = class_getClassMethod(c, origSEL);
        if(!origMethed) {
            return;
        }
        newMethod = class_getClassMethod(c, newSEL);
        if(!newMethod) {
            return;
        }
    }
    else {
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }
    
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, newSEL, method_getImplementation(origMethed), method_getTypeEncoding(origMethed));
    }
    else {
        method_exchangeImplementations(newMethod, origMethed);
    }
}
