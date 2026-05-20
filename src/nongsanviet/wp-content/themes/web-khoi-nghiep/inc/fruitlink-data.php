<?php

if (!defined('ABSPATH')) {
    exit;
}

function fruitlink_get_demo_packages() {
    return [
        [
            'name' => 'Cam Cao Phong',
            'region' => 'Hòa Bình',
            'farm_name' => 'Trang trại Gia đình Nguyễn',
            'status' => 'Đang gọi vốn',
            'status_key' => 'funding',
            'funding_percentage' => 65,
            'min_investment' => '5.000.000đ',
            'expected_harvest' => 'Tháng 10/2026',
            'traceability_status' => 'Đã kích hoạt QR',
            'latest_update' => 'Cây đang ra hoa, dự kiến đậu quả sau 2 tuần.',
            'visual_class' => 'orange-green',
        ],
        [
            'name' => 'Xoài Cát Hòa Lộc',
            'region' => 'Tiền Giang',
            'farm_name' => 'Vườn Hòa Lộc Xanh',
            'status' => 'Đang canh tác',
            'status_key' => 'growing',
            'funding_percentage' => 82,
            'min_investment' => '3.000.000đ',
            'expected_harvest' => 'Tháng 07/2026',
            'traceability_status' => 'Nhật ký số 12 cập nhật',
            'latest_update' => 'Đã bao trái đợt 1, kiểm tra sâu bệnh định kỳ.',
            'visual_class' => 'cream-orange',
        ],
        [
            'name' => 'Sầu riêng Đắk Lắk',
            'region' => 'Đắk Lắk',
            'farm_name' => 'Hợp tác xã Krông Pắc',
            'status' => 'Sắp thu hoạch',
            'status_key' => 'harvest',
            'funding_percentage' => 94,
            'min_investment' => '10.000.000đ',
            'expected_harvest' => 'Tháng 08/2026',
            'traceability_status' => 'Có lịch tham quan vườn',
            'latest_update' => 'Trái đạt kích thước tốt, chuẩn bị kiểm tra độ chín.',
            'visual_class' => 'green-yellow',
        ],
        [
            'name' => 'Thanh long Bình Thuận',
            'region' => 'Bình Thuận',
            'farm_name' => 'Vườn Thuận Phát',
            'status' => 'Đang gọi vốn',
            'status_key' => 'funding',
            'funding_percentage' => 48,
            'min_investment' => '2.000.000đ',
            'expected_harvest' => 'Tháng 06/2026',
            'traceability_status' => 'Đang hoàn thiện hồ sơ QR',
            'latest_update' => 'Luống mới được chăm bón hữu cơ sau mưa.',
            'visual_class' => 'mint-pink',
        ],
    ];
}

function fruitlink_get_flow_steps() {
    return [
        ['title' => 'Đăng ký', 'text' => 'Tạo tài khoản và xác thực OTP để bắt đầu hành trình đầu tư nông sản.'],
        ['title' => 'Khám phá', 'text' => 'Chọn nông sản, xem vùng trồng, QR truy xuất và thông tin nông dân.'],
        ['title' => 'Đầu tư', 'text' => 'Góp vốn ban đầu, nhận mã đầu tư và quyền theo dõi mùa vụ.'],
        ['title' => 'Theo dõi', 'text' => 'Xem nhật ký canh tác, nhận thông báo và cập nhật từ vườn.'],
        ['title' => 'Thu hoạch', 'text' => 'Nhận nông sản hoặc đặt tour về vườn để trải nghiệm thu hoạch.'],
        ['title' => 'Tích lũy', 'text' => 'Tích điểm thành viên, nâng hạng đầu tư và tái đầu tư mùa vụ mới.'],
    ];
}

function fruitlink_get_dashboard_stats() {
    return [
        ['label' => 'Tổng vốn đã đầu tư', 'value' => '28.000.000đ'],
        ['label' => 'Gói đang theo dõi', 'value' => '4 mùa vụ'],
        ['label' => 'Điểm thành viên', 'value' => '1.280 điểm'],
        ['label' => 'Hạng đầu tư', 'value' => 'Nhà đầu tư Xanh'],
    ];
}

function fruitlink_get_diary_items() {
    return [
        ['date' => 'Tuần 01', 'title' => 'Chuẩn bị đất và kiểm tra nguồn nước', 'text' => 'Nông dân hoàn tất cải tạo đất, cập nhật hình ảnh lên nhật ký số.'],
        ['date' => 'Tuần 04', 'title' => 'Chăm sóc cây và bón hữu cơ', 'text' => 'Quy trình chăm sóc được ghi nhận để phục vụ truy xuất nguồn gốc.'],
        ['date' => 'Tuần 08', 'title' => 'Kiểm tra chất lượng và dự báo sản lượng', 'text' => 'Hệ thống gửi thông báo tiến độ cho nhà đầu tư trước kỳ thu hoạch.'],
    ];
}
