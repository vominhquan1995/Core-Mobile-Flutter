// import 'package:Midas/widgets/quan_ly_don_hang/model/index.dart';

// /**
//  * Thời gian sẽ fomat lại từ api
//  * Tình trạng: 0 - Đợi thanh toán, 1 - Đã thanh toán, (-1) - Đã hủy
//  * Hình thức thanh toán: 1 - Thanh toán tiền mặt, 2 - Thanh toán chuyển khoản
//  */
// List<DonHangModel> dataMau = [
//   new DonHangModel(
//       ten_san_pham:
//           'Recovery Shampoo - dầu gội cho tóc hư tổn 430 ml, Recovery Shampoo - dầu gội cho tóc hư tổn 830 ml',
//       ma_don_hang: '45485116',
//       thoi_gian: '7:20 - 2012/11/07',
//       tinh_trang: '1',
//       nguoi_nhan: 'Nguyễn Văn Ngọc',
//       so_dien_thoai: '0901231233',
//       dia_chi_nhan: '83 Phan Kế Bính - Hồ Chí Minh - Quận 1 - Phường Đa Khao',
//       ghi_chu: 'Giao buổi sang, tầm 7h.',
//       hinh_thuc_thanh_toan: '1',
//       tong_tien: '1,785,000',
//       san_pham: [
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '10,208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//       ]),
//   new DonHangModel(
//       ten_san_pham:
//           'Recovery Shampoo - dầu gội cho tóc hư tổn 430 ml, Recovery Shampoo - dầu gội cho tóc hư tổn 830 ml',
//       ma_don_hang: '45485116',
//       thoi_gian: '7:20 - 2012/11/07',
//       tinh_trang: '-1',
//       nguoi_nhan: 'Nguyễn Văn Ngọc',
//       so_dien_thoai: '0901231233',
//       dia_chi_nhan: '83 Phan Kế Bính - Hồ Chí Minh - Quận 1 - Phường Đa Khao',
//       ghi_chu: 'Giao buổi sang, tầm 7h.',
//       hinh_thuc_thanh_toan: '2',
//       san_pham: [
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//       ]),
//   new DonHangModel(
//       ten_san_pham:
//           'Recovery Shampoo - dầu gội cho tóc hư tổn 430 ml, Recovery Shampoo - dầu gội cho tóc hư tổn 830 ml',
//       ma_don_hang: '45485116',
//       thoi_gian: '7:20 - 2012/11/07',
//       tinh_trang: '0',
//       nguoi_nhan: 'Nguyễn Văn Ngọc',
//       so_dien_thoai: '0901231233',
//       dia_chi_nhan: '83 Phan Kế Bính - Hồ Chí Minh - Quận 1 - Phường Đa Khao',
//       ghi_chu: 'Giao buổi sang, tầm 7h.',
//       hinh_thuc_thanh_toan: '1',
//       tong_tien: '1,785,000',
//       san_pham: [
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//       ]),
//   new DonHangModel(
//       ten_san_pham:
//           'Recovery Shampoo - dầu gội cho tóc hư tổn 430 ml, Recovery Shampoo - dầu gội cho tóc hư tổn 830 ml',
//       ma_don_hang: '45485116',
//       thoi_gian: '7:20 - 2012/11/07',
//       tinh_trang: '1',
//       nguoi_nhan: 'Nguyễn Văn Ngọc',
//       so_dien_thoai: '0901231233',
//       dia_chi_nhan: '83 Phan Kế Bính - Hồ Chí Minh - Quận 1 - Phường Đa Khao',
//       ghi_chu: 'Giao buổi sang, tầm 7h.',
//       hinh_thuc_thanh_toan: '2',
//       san_pham: [
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//       ]),
//   new DonHangModel(
//       ten_san_pham:
//           'Recovery Shampoo - dầu gội cho tóc hư tổn 430 ml, Recovery Shampoo - dầu gội cho tóc hư tổn 830 ml',
//       ma_don_hang: '45485116',
//       thoi_gian: '7:20 - 2012/11/07',
//       tinh_trang: '1',
//       nguoi_nhan: 'Nguyễn Văn Ngọc',
//       so_dien_thoai: '0901231233',
//       dia_chi_nhan: '83 Phan Kế Bính - Hồ Chí Minh - Quận 1 - Phường Đa Khao',
//       ghi_chu: 'Giao buổi sang, tầm 7h.',
//       hinh_thuc_thanh_toan: '2',
//       san_pham: [
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//       ]),
//   new DonHangModel(
//       ten_san_pham:
//           'Recovery Shampoo - dầu gội cho tóc hư tổn 430 ml, Recovery Shampoo - dầu gội cho tóc hư tổn 830 ml',
//       ma_don_hang: '45485116',
//       thoi_gian: '7:20 - 2012/11/07',
//       tinh_trang: '1',
//       nguoi_nhan: 'Nguyễn Văn Ngọc',
//       so_dien_thoai: '0901231233',
//       dia_chi_nhan: '83 Phan Kế Bính - Hồ Chí Minh - Quận 1 - Phường Đa Khao',
//       ghi_chu: 'Giao buổi sang, tầm 7h.',
//       hinh_thuc_thanh_toan: '1',
//       tong_tien: '1,785,000',
//       san_pham: [
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//         {
//           'ten_san_pham':
//               'Leave in Hair Cream - kem xả khô giàu dinh dưỡng 100 ml',
//           'don_gia': '208,000',
//           'so_luong': '1',
//           'hinh_anh': 'https://www.refinery29.com/images/8806438.jpg?format=webp&width=720&height=864&quality=85'
//         },
//       ]),
// ];
