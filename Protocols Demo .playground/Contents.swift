//: Playground - noun: a place where people can play

import UIKit

/** 协议分享demo **/
 
 /// 枚举、结构体可以遵守协议了（Objective-C不行）
 /// 制作一个App证书生成器（假设需要使用者传入私钥以及公钥类型）
 /// 附带了解函数式编程思想
enum YaoFangCertificate {
    case YYW, YiZhen, FangKuaiYi
}

/// 耀方证书公钥生成函数
func makeYaofangCertificateKey(inputCertificate: YaoFangCertificate) -> String {
    switch inputCertificate {
    case .YYW: return "1药网app证书公钥"
    case .YiZhen: return "1诊app证书公钥"
    case .FangKuaiYi: return "方块1app证书公钥"
    }
}

/// 耀方app证书生成函数
func makeYaofangAppCertificate(privateKey: String, certificate: YaoFangCertificate) -> String {
    return "[\(privateKey)] + [\(makeYaofangCertificateKey(certificate))] -> app证书"
}

let yyw = YaoFangCertificate.YYW
makeYaofangAppCertificate("yyw12345", certificate: yyw)

/// 若需要添加腾讯公司的产品证书时
enum TencentCertificate {
    case QQ, Wechat
}

/// 腾讯证书公钥生成函数
func makeTencentCertificateKey(inputCertificate: TencentCertificate) -> String {
    switch inputCertificate {
    case .QQ: return "QQapp证书公钥"
    case .Wechat: return "微信app证书公钥"
    }
}

/// 腾讯app证书生成函数
func makeTencentAppCertificate(privateKey: String, certificate: TencentCertificate) -> String {
    return "[\(privateKey)] + [\(makeTencentCertificateKey(certificate))] -> app证书"
}

let qq = TencentCertificate.QQ
makeTencentAppCertificate("qq12345", certificate: qq)

/// 通过扩展枚举采纳公共协议改进
protocol KeyProtocol {
    func makePublicCertificateKey() -> String
}

extension YaoFangCertificate: KeyProtocol {
    func makePublicCertificateKey() -> String {
        switch self {
        case .YYW: return "1药网app证书公钥"
        case .YiZhen: return "1诊app证书公钥"
        case .FangKuaiYi: return "方块1app证书公钥"
        }
    }
}

extension TencentCertificate: KeyProtocol {
    func makePublicCertificateKey() -> String {
        return "腾讯公司统一证书公钥"
    }
    func makeMobilePrivateKey(companyName: String) -> String {
        return "\(companyName)12345"
    }
}

/// 把KeyProtocol协议作为类型使用的应用场景
func makeAppCertificate(privateKey: String, certificate: KeyProtocol) -> String {
    return "[\(privateKey)] + [\(certificate.makePublicCertificateKey())] -> app证书"
}

var yz = YaoFangCertificate.YiZhen
var QQ = TencentCertificate.QQ
makeAppCertificate("yizhen12345", certificate: yz)
makeAppCertificate("QQ12345", certificate: QQ)

/// 代码的可延展性大大提升类 -- 任何遵守 PublicKeyMakeable 协议的类型都可以被格式化
/// 比如阿里巴巴公司的类型为结构体
struct Alibaba: KeyProtocol {
    func makePublicCertificateKey() -> String {
        return "Alibaba公司统一证书公钥"
    }
}

var zhifubao = Alibaba()
makeAppCertificate("zhifubao12345", certificate: zhifubao)

/// swfit2.0新特性：加入了扩展协议，可对协议进行属性或者方法的扩展
/// 开启了面向协议编程的篇章
/// PublicKeyMakeable只能生成证书Key，新增需求要求打印公司名
extension KeyProtocol {
    func makeMobilePrivateKey(companyName: String) -> String {
        return "\(companyName)54321"
    }
    func makePcPrivateKey(companyName: String) -> String {
        return "\(companyName)11111"
    }
}
makeAppCertificate(yz.makeMobilePrivateKey("yizhen Mobile "), certificate: yz)
makeAppCertificate(yz.makePcPrivateKey("yizhen PC "), certificate: yz)
makeAppCertificate(QQ.makeMobilePrivateKey("QQ"), certificate: QQ)
makeAppCertificate(QQ.makePcPrivateKey("QQ PC"), certificate: QQ)

UIImage(imageLiteral: "protocols-extend-480x280")


/// 相比于使用基类(抽象类)而言，protocol的优势？
/*
Why Not Base Classes?
Protocol extensions and default implementations may seem similar to using a base class or even abstract classes in other languages, but they offer a few key advantages in Swift:
Because types can conform to more than one protocol, they can be decorated with default behaviors from multiple protocols. Unlike multiple inheritance of classes which some programming languages support, protocol extensions do not introduce any additional state.
Protocols can be adopted by classes, structs and enums. Base classes and inheritance are restricted to class types.
In other words, protocol extensions provide the ability to define default behavior for value types and not just classes.
*/




