//
//  ContentView.swift
//  BucketList
//
//  Created by Bosco on 23/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    
//    Those views could be nested if you want, but they don’t have to be – it really depends on whether you plan to use them elsewhere and the size of your app.

//    With those two parts in place, we now effectively use ContentView as a simple wrapper that tracks the current app state and shows the relevant child view. That means giving it a property to store the current LoadingState value:
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
