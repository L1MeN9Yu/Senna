//
//  Singleton.h
//  Senna
//
//  Created by Mengyu Li on 2019/9/2.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

template<typename T>

class Singleton {
private:
    static T *pSingleton;

    Singleton() {
    }

public:
    static T *sharedInstance() {
        return pSingleton;
    }
};


template<typename T>
T *Singleton<T>::pSingleton = new T;

#endif /* Singleton_h */
