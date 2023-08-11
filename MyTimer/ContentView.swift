    //
    //  ContentView.swift
    //  MyTimer
    //
    //  Created by 大本詩織 
    //

    import SwiftUI

    struct ContentView: View {
        //音を鳴らす用
        let soundPlayer = SoundPlayer()
        
        //タイマーの変数を作成
        @State var timerHandler : Timer?
        //経過時間の変数を作成
        @State var count = 0
        //設定した時間を取得
        @AppStorage("timer_value") var timerValue = 180
        
        //場面用の変数
        @State var scene = 0
        
        @State var showAlert = false;
        
        var body: some View {
            NavigationStack{
                ZStack{
                    Image("backgroundPome")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    
                    if scene == 0 {
                        VStack{
                            Text("筋トレを")
                                .font(.title)
                                .fontWeight(.semibold)
                            Text("始めましょう")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.bottom, 15.0)
                            Image("start")
                                .resizable()
                                .scaledToFit()
                            
                            Button{
                                scene = 1
                            }label:{
                                Text("Start")
                                    .font(.largeTitle)
                                    .frame(width: 300)
                                    .frame(height: 100)
                                    .background(Color(hue: 0.516, saturation: 0.179, brightness: 0.642, opacity: 0.733))
                                    .foregroundColor(Color.white)
                                    
                            }
                        }//VStack終わり
                    }//scene == 0終わり
                    
                    else if scene == 1 {
                        
                            
                        VStack{
                            GIFView(gifName: "example")
                                .padding(.bottom)
                                .frame(width: 250.0, height: 300.0)
                                //.scaledToFit()
            
                            
                            if timerValue - count <= 60{
                                Text("残り\(timerValue - count)秒")
                                    .font(.largeTitle)
                            }
                            
                            else{
                                Text("残り\((timerValue - count)/60)分\((timerValue - count)%60)秒")
                                    .font(.largeTitle)
                            }
                            HStack{
                                Button{
                                    //ボタンをタップした時のアクション
                                    startTimer()
                                }label:{
                                    Text("スタート")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .frame(width: 140,height:140)
                                        .background(Color("startColor"))
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    
                                }
                                
                                Button{
                                    //ボタンをタップした時のアクション
                                    if let unwrapedTimerhandler  = timerHandler{
                                        if unwrapedTimerhandler.isValid == true{
                                            unwrapedTimerhandler.invalidate()
                                        }
                                    }
                                }label:{
                                    Text("ストップ")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .frame(width: 140,height:140)
                                        .background(Color("stopColor"))
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    
                                }
                               
                                
                            }//HStack終わり
                        }//VStack終わり
                    }//scene == 0 終わり
                    
                    else{
                        VStack{
                            ZStack{
                                Text("\(timerValue/60)分")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hue: 0.1, saturation: 0.257, brightness: 0.251))
                                    .padding(.vertical, 30.0)
                                    .padding(.horizontal, 50.0)
                                    .background(Color(hue: 0.105, saturation: 0.688, brightness: 0.883, opacity: 0.861))
                                
                                Image("frame")
                                    .resizable()
                                    .frame(width: 200.0, height: 130.0)
                                    .scaledToFit()
                            }
                            if timerValue <= 300{
                                Text("やるだけで偉いで賞")
                                    .font(.headline)
                                    .padding(.top)
                                    .underline()
                                
                                Text("よければもうちょっとだけ")
                                Text("頑張ってみませんか...?")
                                Image("neko1")
                                    .resizable()
                                    .scaledToFit()
                            }
                            else if timerValue <= 1200{
                                Text("頑張ったで賞")
                                    .font(.headline)
                                    .padding(.top)
                                    .underline()
                                
                                Text("あなたの筋肉がちょびっと")
                                Text("増えました。偉い。")
                                Image("neko2")
                                    .resizable()
                                    .padding([.leading, .bottom, .trailing])
                                    .scaledToFit()
                            }
                            
                           
                            else if timerValue <= 1800{
                                Text("頑張りすぎで賞")
                                    .font(.headline)
                                    .padding(.top)
                                    .underline()
                                
                                Text("あなたの筋肉がかなり成長しました。")
                                Text("あなたの頑張りに乾杯。")
                             
                                Image("neko3")
                                    .resizable()
                                    .padding(.all)
                                    .frame(width: 250.0, height: 400.0)
                                    .scaledToFit()
                            }
                            else{
                                Text("あなたは神で賞")
                                    .font(.headline)
                                    .padding(.top)
                                    .underline()
                                
                                Text("もはや何も言うことはありません。")
                                Text("無理しすぎないようにしてください。")
                             
                                Image("tassei")
                                    .resizable()
                                    .padding(.all)
                                    .scaledToFit()
                            }
                            
                            
                            
                            Button{
                                scene = 0
                            }label:{
                                Text("🌸スタート画面へ🌸")
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 200)
                                    .frame(height: 60)
                                    .background(Color(hue: 0.516, saturation: 0.179, brightness: 0.642, opacity: 0.733))
                                    .foregroundColor(Color.white)
                                    
                            }
                        }
                    }//scene == 2終わり
                }//ZStack終わり
                
                //時間設定したら画面を更新
                .onAppear{
                    count = 0
                }
                //ボタンを追加
                .toolbar{
                    //右に配置
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink{//遷移
                            SettingView()
                        }label: {
                            Text("時間設定")
                        }
                    }
                }
                
                //showAlertがtrueの時
                .alert("達成",isPresented: $showAlert){
                    Button{
                        //ボタンがタップされた時に実行
                        soundPlayer.cymbalPlay()
                        scene = 2
                        
                    }label: {
                        Text("今日の成果は？")
                    }
                }
                message:{
                    Text("よく頑張りました！")
                        
                }
                
                
            }
            
            
        }
        
        //1秒ごとに実行されてカウントダウンする
        func countDownTimer(){
            count += 1
            if timerValue - count <= 0{
                //タイマー停止
                timerHandler?.invalidate()
                
                //アラート表示
                showAlert = true
                
            }
        }
        
        //タイマーのカウントダウン開始
        func startTimer(){
            if let unwrapedTimerHandler = timerHandler{
                //もしタイマーが実行中ならスタートしない
                if unwrapedTimerHandler.isValid == true{
                    return
                }
            }
            
            if timerValue - count <= 0{
                count = 0
            }
            
            //タイマースタート
            timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                countDownTimer()
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
