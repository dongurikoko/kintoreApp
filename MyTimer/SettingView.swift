//
//  SettingView.swift
//  MyTimer
//
//  Created by 大本詩織 
//

import SwiftUI

struct SettingView: View {
    @AppStorage("timer_value") var timerValue = 180
    var body: some View {
        ZStack{
            //背景色
            Color("backgroundSetting")
                .ignoresSafeArea()
            //縦方向にレイアウト
            VStack{
                Spacer()
                Text("\(timerValue/60)分")
                    .font(.largeTitle)
                
                Picker(selection: $timerValue){
                    Text("3分")
                        .tag(180)
                    Text("5分")
                        .tag(300)
                    Text("10分")
                        .tag(600)
                    Text("15分")
                        .tag(900)
                    Text("20分")
                        .tag(1200)
                    Text("25分")
                        .tag(1500)
                    Text("30分")
                        .tag(1800)
                    Text("幻の60分")
                        .tag(3600)
                }label:{
                    Text("選択")
                }
                .pickerStyle(.wheel)
                
                Spacer()
            }
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
