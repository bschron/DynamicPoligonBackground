//
//  List.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/26/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation

public class List<T> {
    // MARK: -Properties
    private(set) public var list: NSMutableArray = NSMutableArray()
    public var count: Int {
        return self.list.count
    }
    public var last: T? {
        return self.list.lastObject as? T
    }
    
    // MARK: -MethodsisOrderedBefore
    public func insert(object: T) {
        self.list.addObject(object as! AnyObject)
    }
    
    public func removeLast() {
        self.list.removeLastObject()
    }
    
    public func insert(array: [T]) {
        for cur in array {
            self.insert(cur)
        }
    }
    
    public func insert(list: List<T>) {
        for cur in list.list {
            self.insert(cur as! T)
        }
    }
    
    public func getFirstObject() -> T? {
        return self.count > 0 ? self.list.objectAtIndex(0) as? T : nil
    }
    
    public func getLastObject() -> T? {
        return self.count > 0 ? self.list.objectAtIndex(self.list.count - 1) as? T : nil
    }
    
    public func getElementAtIndex(index: Int) -> T? {
        return index <= self.count ? self.list.objectAtIndex(index) as? T : nil
    }
    
    public func removeAtIndex(index: Int) {
        if index < self.count {
            self.list.removeObjectAtIndex(index)
        }
    }
    
    public func removeObject(parameter: (T) -> Bool) -> Bool {
        var result = false
        
        var i = 0
        for cur in self.list {
            if parameter(cur as! T) {
                result = true
                break
            }
            i++
        }
        removeAtIndex(i)
        
        return result
    }
    
    public func findBy(parameter: (T) -> Bool) -> List<T> {
        var desired: List<T> = List<T>()
        
        for cur in self.list {
            if parameter(cur as! T) {
                desired.insert(cur as! T)
            }
        }
        
        return desired
    }
    
    public func clearList() {
        self.list = []
    }
    
    public func arrayCopy() -> Array<T> {
        var array = Array<T>()
        for cur in self.list {
            array += [cur as! T]
        }
        return array
    }
    
    public func getObjectIndex(indexFor object: T, compareBy parameter: (T) -> Bool) -> Int? {
        var i: Int = 0
        var result: Int?
        for cur in self.list {
            if parameter(cur as! T) {
                result = i
                break
            }
            i++
        }
        
        return result
    }
    
    public func exists(object: T, compareBy parameter: (T) -> Bool) -> Bool {
        return self.getObjectIndex(indexFor: object, compareBy: parameter) != nil
    }
}