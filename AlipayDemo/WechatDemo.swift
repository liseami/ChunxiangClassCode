import SwiftUI

func avatarView(_ uiimage: UIImage?) -> some View {
    Group {
        if uiimage != nil {
            Image(uiImage: uiimage!)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray.opacity(0.6))
                .frame(width: 44, height: 44)
        }
    }
}

// 优化后的消息类型枚举
enum MessageType {
    case text(String)
    case transfer(amount: Double)
    case timestamp(String)
    case video
    case photo
    case url
    case muisc
    
    // 添加一个计算属性来获取消息内容
    var content: String {
        switch self {
        case .text(let str): return str
        case .transfer(let amount): return String(format: "%.2f", amount)
        case .timestamp(let str): return str
        default: return ""
        }
    }
}

// 优化后的消息结构体
struct Message: Identifiable {
    let id = UUID()
    let type: MessageType
    let isMine: Bool
}


// 可被观察的对象
class WechatDemoViewModel : ObservableObject{
    @Published var showEditView  : Bool = false
    @Published var avatar1 : UIImage?
    @Published var avatar2 : UIImage?
    // 使用优化后的数据结构重构消息数组
    @Published var messages: [Message] = [
        Message(type: .text("咱们现在周末还有课吗？"), isMine: false),
        Message(type: .timestamp("2月15日 10:15"), isMine: true),
        Message(type: .text("有的"), isMine: true),
        Message(type: .text("好的，299是吧，直接转给你么"), isMine: false),
        Message(type: .text("是的"), isMine: true),
        Message(type: .transfer(amount: 299), isMine: false),
        Message(type: .transfer(amount: 299), isMine: true),
        Message(type: .text("怎么看回放？"), isMine: false),
        Message(type: .text("入帐后发你"), isMine: true)
    ]
    
    @Published var userTextMessageInput: String = ""
    @Published var userTransMessageInput: String = ""
    @Published var userTimeMessageInput: String = ""
    @Published var showPicker1: Bool = false
    @Published var showPicker2: Bool = false
    @Published var addMessageForMe: Bool = true
    @Published var addMessageType: String = "text"



    
}



struct WechatDemo: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm : WechatDemoViewModel = .init()
    
    
    
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            /// 顶部标题栏
            navigationBar
            /// 消息滚动列表
            messageList
            /// 虚假的微信底部模拟仿真图片
            fakeWechatBottomImage
        }
        .fullScreenCover(isPresented: $vm.showEditView, content: {
            MessagesEditView()
                .environmentObject(vm)
        })
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(hex: "EDEDED"))
    }
    
    
    
    
    
    
    
    
    
    
    
    
    var fakeWechatBottomImage: some View {
        Image("WechatBottomBar")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: UIScreen.main.bounds.width)
    }
    
    var messageList: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                ForEach(vm.messages) { message in
                    switch message.type {
                    case .text, .transfer:
                        messageView(message)
                    case .timestamp(let str):
                        Text(str)
                            .opacity(0.22437)
                    default: EmptyView()
                    }
                }
            }
            .padding()
        }
    }
    
    func messageView(_ message: Message) -> some View {
        HStack(alignment: .top, spacing: 16) {
            if message.isMine {
                Spacer()
            } else {
                avatarView(vm.avatar2)
            }
            
            switch message.type {
            case .text(let text):
                textMessageView(text, isMine: message.isMine)
            case .transfer(let amount):
                transferMessageView(amount: amount, isMine: message.isMine)
            default:
                EmptyView()
            }
            
            if message.isMine {
                avatarView(vm.avatar1)
            } else {
                Spacer()
            }
        }
    }
    
 
    
    func textMessageView(_ text: String, isMine: Bool) -> some View {
        Text(text)
            .padding(.horizontal)
            .padding(.vertical, 13)
            .background(isMine ? Color(hex: "95EC69") : .white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(alignment: isMine ? .trailing : .leading) {
                messageTriangle(color: isMine ? Color(hex: "95EC69") : .white, isMine: isMine)
            }
    }
    
    func transferMessageView(amount: Double, isMine: Bool) -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Image(systemName: "checkmark.circle")
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 4) {
                    Text("¥\(String(format: "%.2f", amount))")
                        .font(.subheadline)
                        .bold()
                    Text(isMine ? "已收款" : "已被接受")
                        .font(.caption2)
                        .bold()
                }
                Spacer()
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.2))
            Text("微信转账")
                .font(.caption2)
        }
        .padding(.bottom, 6)
        .foregroundColor(.white)
        .padding(.horizontal)

        .frame(width: 234, height: 80)
        .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color(hex: "FDE1C3")))
        .overlay(alignment: isMine ? .topTrailing : .topLeading) {
            messageTriangle(color: Color(hex: "FDE1C3"), isMine: isMine)
                .padding(.top, 13)

        }
    }
    
    func messageTriangle(color: Color, isMine: Bool) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 10, height: 10)
            .foregroundColor(color)
            .rotationEffect(.degrees(45))
            .offset(x: isMine ? 5 : -5)
    }
    
    var navigationBar: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .rotationEffect(.degrees(90))
                }
                
                Spacer()
                
                Button(action: { vm.showEditView = true }) {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal)
            .overlay {
                Text("某某某")
                    .font(.title3)
            }
            
            Rectangle()
                .foregroundColor(Color(hex: "D5D5D5"))
                .frame(height: 1)
        }
        .padding(.top, 12)
    }
}

#Preview {
    WechatDemo()
}
