# FruitLink UI/UX Redesign Spec

## Goal

Rebuild the current WordPress frontend into a FruitLink prototype that presents the product as an agri-tech investment platform for Vietnamese agricultural products.

The prototype should demonstrate the full product story:

- Why agricultural products need a better supply and investment model.
- How FruitLink connects farmers, investors, and consumers.
- How users discover agricultural investment packages.
- How users track cultivation progress and harvest benefits.
- How hAgri supports digital farming, traceability, and transparent production.

The result should be suitable for local demo and presentation at `http://localhost:8080`.

## Current context

The project is a restored WordPress site running locally through Docker Compose.

- WordPress frontend is currently based on the Flatsome parent theme and the `web-khoi-nghiep` child theme.
- Current content is from an old electronics shop demo.
- WooCommerce exists, but the first FruitLink version should not depend on real checkout or payment logic.
- The source narrative is captured in [fruitlink-analysis.md](../../../fruitlink-analysis.md).

## Chosen approach

Use the existing WordPress + Flatsome child theme as the delivery surface, but build a FruitLink-specific prototype UI layer.

This approach is preferred because it is fastest for demo value:

- It reuses the existing WordPress setup.
- It avoids rebuilding the project from scratch.
- It allows the local site to immediately show the new FruitLink experience.
- It keeps the scope focused on UI/UX and product storytelling.

The first implementation should be a polished prototype, not a complete investment backend.

## Non-goals

This redesign will not implement:

- Real OTP authentication.
- Real payment processing.
- Real investment contracts.
- Real investor wallet logic.
- Real farmer messaging.
- Real QR traceability backend.
- Full WooCommerce checkout customization.

Static or hardcoded demo data is acceptable for this phase.

## Visual direction

The interface should feel like a modern agri-tech and light fintech product.

The desired qualities are:

- Trustworthy.
- Transparent.
- Fresh and agricultural.
- Technology-enabled.
- Friendly to Vietnamese users.
- More like an investment platform than a basic ecommerce shop.

Suggested palette:

- Deep green `#1f5f35` for trust and agriculture.
- Fresh leaf green `#47a447` for growth and positive status.
- Warm orange `#f97316` for investment CTAs.
- Harvest yellow `#f8c74d` for highlights and progress accents.
- Soft cream `#fff8e7` and pale green `#eef8ec` for backgrounds.
- White cards with subtle depth.
- Text charcoal `#1f2933` and muted text `#64748b`.

Typography should use the theme's existing font stack unless the active child theme already defines a cleaner site font. Prioritize readability over decorative typography.

Image direction:

- Use available WordPress media if it is agricultural or neutral.
- Avoid electronics/product imagery from the old demo.
- If new image URLs are needed, use royalty-free agricultural placeholders only for prototype purposes.
- Prefer 16:10 or 4:3 image ratios for package cards, and a wide hero visual for the top section.

The UI should avoid the previous electronics-shop feeling.

## Information architecture

The prototype should contain four main areas.

### 1. Home / Product story

Purpose: explain FruitLink quickly and create trust.

Recommended sections:

1. Hero
   - Main headline: “FruitLink – Kết nối đầu tư nông sản minh bạch”.
   - Supporting text about connecting farmers, investors, and consumers.
   - CTAs: “Khám phá nông sản”, “Xem cách hoạt động”.
   - Visual cues: farm cards, investment progress, harvest iconography.

2. Problem section
   - Broken supply chains.
   - Farmers losing direct connection with consumers.
   - Middlemen pressuring prices.
   - Hard-to-trace product quality.
   - Unstable output.

3. Solution section
   - FruitLink connects farmers, investors, and consumers.
   - Users can invest, follow cultivation, and receive agricultural products.
   - Farmers receive upfront capital and more stable output.

4. User flow section
   - Register / login.
   - Discover agricultural products.
   - Invest.
   - Track cultivation.
   - Visit and harvest.
   - Accumulate benefits.

5. hAgri technology section
   - Digital farming diary.
   - Traceability.
   - Product branding.
   - Local agricultural digitization.
   - Farming supervision.

### 2. Marketplace

Purpose: make FruitLink feel like a usable agricultural investment product.

Recommended elements:

- Filter chips for product type, region, capital range, and harvest time.
- Investment package cards.
- Each card should show:
  - Product name.
  - Region.
  - Farmer or farm name.
  - Funding progress.
  - Expected harvest time.
  - Minimum investment amount.
  - Traceability or QR status.
  - Status badge: “Đang gọi vốn”, “Đang canh tác”, “Sắp thu hoạch”.

Example packages:

- Cam Cao Phong.
- Xoài Cát Hòa Lộc.
- Sầu riêng Đắk Lắk.
- Thanh long Bình Thuận.

Primary CTA: “Đầu tư ngay”.

### 3. Investment detail preview

Purpose: show what users get after selecting a package.

Recommended sections:

- Product overview.
- Farm and region information.
- Investment progress.
- Expected yield or user benefit.
- Cultivation timeline.
- Sample QR traceability block.
- Farmer update card.
- Harvest/tour option.

For this prototype, implement the investment detail preview as an in-page highlighted section below the marketplace. Do not create a separate page or modal in the first iteration.

### 4. User dashboard prototype

Purpose: demonstrate the post-investment experience.

Recommended sections:

- Total invested amount.
- Active investments.
- Cultivation progress timeline.
- Latest farming diary updates.
- Member points.
- Investment tier.
- Suggested reinvestment or harvest tour.

The dashboard can use static demo data.

## Navigation

The top navigation should prioritize the FruitLink journey:

- FruitLink logo / name.
- Khám phá nông sản.
- Cách hoạt động.
- Nhật ký canh tác.
- Quyền lợi.
- Dashboard.
- CTA: “Đầu tư ngay”.

If WordPress admin bar is visible for logged-in admins, it can remain unchanged.

## Content tone

Vietnamese copy should be clear, product-oriented, and trustworthy.

Tone guidelines:

- Use simple, direct Vietnamese.
- Avoid exaggerated financial promises.
- Emphasize transparency, traceability, and shared value.
- Frame investment as support and participation in agricultural production.
- Avoid implying guaranteed financial returns unless backend/legal content exists.

Content sourcing:

- Adapt Vietnamese copy directly from [fruitlink-analysis.md](../../../fruitlink-analysis.md), especially sections 2 through 8.
- Keep copy short enough for UI cards and landing sections.
- Prefer functional clarity over poetic marketing language.
- Do not use Lorem Ipsum.

## Data model for prototype

Use hardcoded demo data in a child-theme data helper, preferably `inc/fruitlink-data.php`, then render that data from the FruitLink template. Create 4 demo packages in the first iteration.

Example PHP structure:

```php
function fruitlink_get_demo_packages() {
    return [
        [
            'name' => 'Cam Cao Phong',
            'region' => 'Hòa Bình',
            'farm_name' => 'Trang trại Gia đình Nguyễn',
            'status' => 'Đang gọi vốn',
            'funding_percentage' => 65,
            'min_investment' => '5.000.000đ',
            'expected_harvest' => 'Tháng 10/2026',
            'traceability_status' => 'Đã kích hoạt QR',
            'latest_update' => 'Cây đang ra hoa, dự kiến đậu quả sau 2 tuần.',
        ],
        [
            'name' => 'Xoài Cát Hòa Lộc',
            'region' => 'Tiền Giang',
            'farm_name' => 'Vườn Hòa Lộc Xanh',
            'status' => 'Đang canh tác',
            'funding_percentage' => 82,
            'min_investment' => '3.000.000đ',
            'expected_harvest' => 'Tháng 07/2026',
            'traceability_status' => 'Nhật ký số 12 cập nhật',
            'latest_update' => 'Đã bao trái đợt 1, kiểm tra sâu bệnh định kỳ.',
        ],
        [
            'name' => 'Sầu riêng Đắk Lắk',
            'region' => 'Đắk Lắk',
            'farm_name' => 'Hợp tác xã Krông Pắc',
            'status' => 'Sắp thu hoạch',
            'funding_percentage' => 94,
            'min_investment' => '10.000.000đ',
            'expected_harvest' => 'Tháng 08/2026',
            'traceability_status' => 'Có lịch tham quan vườn',
            'latest_update' => 'Trái đạt kích thước tốt, chuẩn bị kiểm tra độ chín.',
        ],
        [
            'name' => 'Thanh long Bình Thuận',
            'region' => 'Bình Thuận',
            'farm_name' => 'Vườn Thuận Phát',
            'status' => 'Đang gọi vốn',
            'funding_percentage' => 48,
            'min_investment' => '2.000.000đ',
            'expected_harvest' => 'Tháng 06/2026',
            'traceability_status' => 'Đang hoàn thiện hồ sơ QR',
            'latest_update' => 'Luống mới được chăm bón hữu cơ sau mưa.',
        ],
    ];
}
```

This keeps the prototype simple while preserving a future path to WooCommerce products or custom post types.

## Implementation boundaries

The implementation should:

- Prefer editing the active child theme rather than WordPress core.
- Avoid modifying WordPress core files.
- Avoid deep WooCommerce checkout changes in this phase.
- Keep styles scoped to FruitLink UI to avoid unnecessary admin impact.
- Use existing local assets where useful, but replace electronics-oriented imagery/copy.
- Keep the site available at `http://localhost:8080`.

Implementation decisions:

- Use the homepage as the primary FruitLink prototype surface.
- Replace or override the existing homepage output rather than creating a separate hidden demo page.
- Keep the top navigation as anchor links on the same page for the first iteration.
- Keep the investment detail preview and dashboard prototype on the same page.
- Use static demo data for all dashboard and marketplace values.

Responsive strategy:

- Leverage Flatsome's existing responsive behavior where it does not fight the FruitLink layout.
- Use custom scoped CSS for FruitLink sections and cards.
- Desktop: full navigation, two-column hero, 3-column package grid.
- Tablet: compact hero, 2-column package grid, filters remain as chips.
- Mobile: stacked hero, single-column cards, dashboard cards stacked vertically, anchor navigation can wrap or collapse via the existing theme behavior.
- Chrome DevTools device emulation is sufficient for prototype verification.

## Testing and verification

Minimum verification:

- Open `http://localhost:8080` and confirm the FruitLink UI appears.
- Confirm the page is responsive at desktop and mobile widths.
- Confirm navigation anchors or sections work.
- Confirm no PHP fatal errors.
- Confirm Docker Compose services stay running.

Preferred visual checks:

- Desktop layout around 1440px.
- Tablet layout around 768px.
- Mobile layout around 375px.

## Success criteria

The redesign is successful when:

- The homepage no longer feels like an electronics shop.
- A visitor can understand FruitLink within the first screen and first few sections.
- The marketplace section makes the investment model concrete.
- The dashboard section shows the post-investment tracking experience.
- The UI matches the FruitLink story in [fruitlink-analysis.md](../../../fruitlink-analysis.md).
- There is no Lorem Ipsum or electronics-shop placeholder copy in the visible FruitLink sections.
- Main CTAs and navigation anchors work.
- The page has no PHP warnings or fatal errors in normal viewing.
- The layout is usable at 1440px, 768px, and 375px widths.
- The prototype is polished enough for demo and presentation.
