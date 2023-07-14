// ignore_for_file: non_constant_identifier_names

class Payload {

  final String? NguonID;
  final String? TenNguon;
  final String? DichID;
  final String? TenDich;
  final int? PhanVungManHinh;
  final String? VungPhat;
  final String? BanTinCongCongID;
  final String? LoaiBanTin;
  final String? MucDoUuTien;
  final String? TieuDe;
  final String? LoaiLinhVuc;
  final String? NoiDungTomTat;
  final int? ThoiGianSanXuat;
  final String? NoiDung;
  final String? DiaBanTao;
  final String? TenDiaBanTao;
  final String? NguonTin;
  final String? ThoiLuong;

  Payload(
      {this.NguonID,
      this.TenNguon,
      this.DichID,
      this.TenDich,
      this.PhanVungManHinh,
      this.VungPhat,
      this.BanTinCongCongID,
      this.LoaiBanTin,
      this.MucDoUuTien,
      this.TieuDe,
      this.LoaiLinhVuc,
      this.NoiDungTomTat,
      this.ThoiGianSanXuat,
      this.NoiDung,
      this.DiaBanTao,
      this.TenDiaBanTao,
      this.NguonTin,
      this.ThoiLuong});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
        NguonID: json['NguonID'],
        TenNguon: json['TenNguon'],
        DichID: json['DichID'],
        TenDich: json['TenDich'],
        PhanVungManHinh: json['PhanVungManHinh'],
        VungPhat: json['VungPhat'],
        BanTinCongCongID: json['BanTinCongCongID'],
        LoaiBanTin: json['LoaiBanTin'],
        MucDoUuTien: json['MucDoUuTien'],
        TieuDe: json['TieuDe'],
        LoaiLinhVuc: json['LoaiLinhVuc'],
        NoiDungTomTat: json['NoiDungTomTat'],
        ThoiGianSanXuat: json['ThoiGianSanXuat'],
        NoiDung: json['NoiDung'],
        DiaBanTao: json['DiaBanTao'],
        TenDiaBanTao: json['TenDiaBanTao'],
        NguonTin: json['NguonTin'],
        ThoiLuong: json['ThoiLuong']);
  }
}
