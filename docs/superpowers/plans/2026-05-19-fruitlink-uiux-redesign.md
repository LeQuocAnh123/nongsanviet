# FruitLink UI/UX Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild the local WordPress homepage into a polished FruitLink agri-tech investment platform prototype.

**Architecture:** Keep WordPress and the active `web-khoi-nghiep` child theme. Add FruitLink-specific data, rendering, and scoped CSS in the child theme, then make the homepage render the FruitLink prototype instead of the old electronics shop content. Use static demo data only.

**Tech Stack:** WordPress, PHP child theme templates, Flatsome parent theme, scoped CSS, Docker Compose local environment.

---

## Source documents

- Spec: `docs/superpowers/specs/2026-05-19-fruitlink-uiux-design.md`
- Narrative source: `fruitlink-analysis.md`
- Active child theme: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/`
- Local site: `http://localhost:8080`

## File structure

Create or modify these files only:

- Modify: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/functions.php`
  - Include FruitLink data and rendering helpers.
  - Enqueue FruitLink stylesheet only on the frontend.
  - Override homepage rendering through a safe WordPress hook.

- Create: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-data.php`
  - Own all static demo data for packages, user flow steps, dashboard metrics, and farming diary items.
  - Expose small helper functions returning arrays.

- Create: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-render.php`
  - Own PHP rendering functions for the FruitLink homepage sections.
  - Escape all dynamic output with WordPress escaping helpers.

- Create: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/fruitlink.css`
  - Own all FruitLink-specific styles under `.fruitlink-page` scope.
  - Do not rewrite global Flatsome or WooCommerce styling.

- Optional modify: `README.md`
  - Only add a short note if verification or local usage changes. This plan should not require README changes.

Do not modify:

- WordPress core files.
- Flatsome parent theme files.
- WooCommerce plugin files.
- Database content unless verification shows the homepage URL must be corrected.

## Task 0: Prepare reversible workspace

**Files:**
- No file changes expected.

- [ ] **Step 1: Inspect current git state**

Run:

```bash
git status --short
```

Expected: note any existing uncommitted files before starting. Do not discard user changes.

- [ ] **Step 2: Keep all FruitLink implementation changes isolated by file scope**

This plan only touches the files listed in the File structure section. Rollback is simple:

```bash
git restore src/nongsanviet/wp-content/themes/web-khoi-nghiep/functions.php src/nongsanviet/wp-content/themes/web-khoi-nghiep/fruitlink.css src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-data.php src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-render.php
```

Only run rollback with user approval.

## Task 1: Add static FruitLink demo data

**Files:**
- Create: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-data.php`

- [ ] **Step 1: Create the child-theme include directory**

Run:

```bash
mkdir -p src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc
```

Expected: command exits 0.

- [ ] **Step 2: Create the data helper file**

Create `src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-data.php` with this exact structure:

```php
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
            'image_gradient' => 'linear-gradient(135deg, #f8c74d, #47a447)',
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
            'image_gradient' => 'linear-gradient(135deg, #fff8e7, #f97316)',
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
            'image_gradient' => 'linear-gradient(135deg, #1f5f35, #f8c74d)',
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
            'image_gradient' => 'linear-gradient(135deg, #e9f7ef, #ec4899)',
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
```

- [ ] **Step 3: Validate PHP syntax**

Run:

```bash
docker compose exec -T wordpress php -l /var/www/html/wp-content/themes/web-khoi-nghiep/inc/fruitlink-data.php
```

Expected: `No syntax errors detected`.

## Task 2: Add FruitLink render helpers

**Files:**
- Create: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-render.php`

- [ ] **Step 1: Create render helper file**

Create `src/nongsanviet/wp-content/themes/web-khoi-nghiep/inc/fruitlink-render.php`. It must:

- Start with the standard `ABSPATH` guard.
- Define `fruitlink_render_homepage()`.
- Define smaller helpers for packages, flow steps, dashboard, and diary.
- Use `esc_html()`, `esc_attr()`, and `esc_url()` for dynamic output.
- Render all content inside a single wrapper: `<main class="fruitlink-page">`.

Use this section order:

1. Navigation bar.
2. Hero.
3. Problem cards.
4. Solution stats.
5. User flow.
6. Marketplace.
7. Investment detail preview.
8. hAgri technology.
9. Dashboard prototype.
10. Harvest CTA.

- [ ] **Step 2: Include minimum render code**

The top-level function should follow this shape:

```php
function fruitlink_render_homepage() {
    $packages = fruitlink_get_demo_packages();
    $flow_steps = fruitlink_get_flow_steps();
    $stats = fruitlink_get_dashboard_stats();
    $diary_items = fruitlink_get_diary_items();

    ob_start();
    ?>
    <main class="fruitlink-page" id="fruitlink-top">
        <!-- render sections here -->
    </main>
    <?php
    return ob_get_clean();
}
```

- [ ] **Step 3: Render package cards from data**

Add a package-card helper that loops through `$packages`. Each card must show:

- Status badge.
- Product name.
- Region.
- Farm name.
- Funding progress bar.
- Minimum investment.
- Expected harvest.
- Traceability status.
- CTA link to `#fruitlink-detail`.

Use this escaping pattern for each package card:

```php
function fruitlink_render_package_cards($packages) {
    if (empty($packages)) {
        return '<p class="fruitlink-empty">Chưa có gói đầu tư nông sản.</p>';
    }

    ob_start();
    foreach ($packages as $package) {
        $progress = max(0, min(100, (int) $package['funding_percentage']));
        ?>
        <article class="fruitlink-package-card fruitlink-status-<?php echo esc_attr($package['status_key']); ?>">
            <div class="fruitlink-package-visual" style="background: <?php echo esc_attr($package['image_gradient']); ?>;"></div>
            <span class="fruitlink-status-badge"><?php echo esc_html($package['status']); ?></span>
            <h3><?php echo esc_html($package['name']); ?></h3>
            <p><?php echo esc_html($package['region']); ?> · <?php echo esc_html($package['farm_name']); ?></p>
            <div class="fruitlink-progress" aria-label="Tiến độ gọi vốn <?php echo esc_attr($progress); ?>%">
                <span style="width: <?php echo esc_attr($progress); ?>%"></span>
            </div>
            <dl class="fruitlink-package-meta">
                <div><dt>Vốn tối thiểu</dt><dd><?php echo esc_html($package['min_investment']); ?></dd></div>
                <div><dt>Thu hoạch</dt><dd><?php echo esc_html($package['expected_harvest']); ?></dd></div>
            </dl>
            <p class="fruitlink-traceability"><?php echo esc_html($package['traceability_status']); ?></p>
            <a class="fruitlink-button fruitlink-button-primary" href="#fruitlink-detail">Đầu tư ngay</a>
        </article>
        <?php
    }
    return ob_get_clean();
}
```

All other render helpers should follow the same pattern: sanitize values before output and return HTML strings from `ob_get_clean()` when markup is more than a few lines.

- [ ] **Step 4: Render dashboard from data**

Render stats from `fruitlink_get_dashboard_stats()` and diary timeline from `fruitlink_get_diary_items()`.

- [ ] **Step 5: Validate PHP syntax**

Run:

```bash
docker compose exec -T wordpress php -l /var/www/html/wp-content/themes/web-khoi-nghiep/inc/fruitlink-render.php
```

Expected: `No syntax errors detected`.

## Task 3: Wire FruitLink into the active child theme

**Files:**
- Modify: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/functions.php`

- [ ] **Step 1: Include the new helper files**

At the end of `functions.php`, add:

```php
require_once get_stylesheet_directory() . '/inc/fruitlink-data.php';
require_once get_stylesheet_directory() . '/inc/fruitlink-render.php';
```

- [ ] **Step 2: Enqueue the FruitLink stylesheet**

Add:

```php
function fruitlink_enqueue_assets() {
    if (is_admin()) {
        return;
    }

    wp_enqueue_style(
        'fruitlink-ui',
        get_stylesheet_directory_uri() . '/fruitlink.css',
        [],
        '1.0.0'
    );
}
add_action('wp_enqueue_scripts', 'fruitlink_enqueue_assets', 20);
```

- [ ] **Step 3: Override homepage content safely**

Add a shortcode and a content filter:

```php
function fruitlink_homepage_shortcode() {
    return fruitlink_render_homepage();
}
add_shortcode('fruitlink_homepage', 'fruitlink_homepage_shortcode');

function fruitlink_replace_front_page_content($content) {
    if (!is_front_page() || is_admin() || !in_the_loop() || !is_main_query()) {
        return $content;
    }

    return fruitlink_render_homepage();
}
add_filter('the_content', 'fruitlink_replace_front_page_content', 20);
```

This makes the local homepage show FruitLink while keeping WordPress admin intact.

- [ ] **Step 4: Validate PHP syntax**

Run:

```bash
docker compose exec -T wordpress php -l /var/www/html/wp-content/themes/web-khoi-nghiep/functions.php
```

Expected: `No syntax errors detected`.

## Task 4: Add scoped FruitLink CSS

**Files:**
- Create: `src/nongsanviet/wp-content/themes/web-khoi-nghiep/fruitlink.css`

- [ ] **Step 1: Create the CSS file**

Create CSS scoped under `.fruitlink-page` only. Include CSS variables:

```css
.fruitlink-page {
  --fl-green-900: #1f5f35;
  --fl-green-600: #47a447;
  --fl-orange: #f97316;
  --fl-yellow: #f8c74d;
  --fl-cream: #fff8e7;
  --fl-mint: #eef8ec;
  --fl-text: #1f2933;
  --fl-muted: #64748b;
}
```

- [ ] **Step 2: Style major sections**

All selectors MUST be prefixed with `.fruitlink-page` to avoid Flatsome conflicts. Use `.fruitlink-page .fruitlink-nav`, not plain `.fruitlink-nav`.

Add styles for:

- `.fruitlink-page .fruitlink-nav`
- `.fruitlink-page .fruitlink-hero`
- `.fruitlink-page .fruitlink-section`
- `.fruitlink-page .fruitlink-problem-grid`
- `.fruitlink-page .fruitlink-flow-grid`
- `.fruitlink-page .fruitlink-market-grid`
- `.fruitlink-page .fruitlink-package-card`
- `.fruitlink-page .fruitlink-progress`
- `.fruitlink-page .fruitlink-detail`
- `.fruitlink-page .fruitlink-dashboard`
- `.fruitlink-page .fruitlink-diary`
- `.fruitlink-page .fruitlink-harvest-cta`

- [ ] **Step 3: Add responsive behavior**

Add these media rules:

```css
@media (max-width: 900px) {
  .fruitlink-page .fruitlink-hero,
  .fruitlink-page .fruitlink-detail,
  .fruitlink-page .fruitlink-dashboard {
    grid-template-columns: 1fr;
  }

  .fruitlink-page .fruitlink-market-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 640px) {
  .fruitlink-page {
    font-size: 15px;
  }

  .fruitlink-page .fruitlink-nav-links,
  .fruitlink-page .fruitlink-market-grid,
  .fruitlink-page .fruitlink-flow-grid,
  .fruitlink-page .fruitlink-problem-grid {
    grid-template-columns: 1fr;
  }

  .fruitlink-page .fruitlink-market-grid {
    display: grid;
  }
}
```

- [ ] **Step 4: Check for CSS syntax mistakes**

Run:

```bash
grep -n "fruitlink" src/nongsanviet/wp-content/themes/web-khoi-nghiep/fruitlink.css | head
```

Expected: selectors are present; command exits 0.

## Task 5: Verify homepage renders FruitLink locally

**Files:**
- No source changes expected unless verification reveals an issue.

- [ ] **Step 1: Ensure Docker services are running**

Run:

```bash
docker compose ps
```

Expected: `wordpress`, `db`, and `phpmyadmin` services are running.

If services are not running, run:

```bash
make up
```

- [ ] **Step 2: Fetch the homepage HTML**

Run:

```bash
curl -fsSL http://localhost:8080 | grep -E "FruitLink|fruitlink-page|Cam Cao Phong|Dashboard"
```

Expected: output includes `FruitLink`, `fruitlink-page`, `Cam Cao Phong`, and `Dashboard` or `Bảng điều khiển`.

- [ ] **Step 3: Verify FruitLink renders exactly once**

Run:

```bash
curl -fsSL http://localhost:8080 | grep -c 'class="fruitlink-page"'
```

Expected: exactly `1`.

- [ ] **Step 4: Check for PHP fatal errors in container logs**

Run:

```bash
docker compose logs --tail=80 wordpress | grep -Ei "fatal error|parse error|warning" || true
```

Expected: no new PHP fatal or parse errors related to FruitLink files.

## Task 6: Browser visual verification

**Files:**
- Modify CSS/render files only if visual verification finds issues.

- [ ] **Step 1: Open local site**

Open:

```text
http://localhost:8080
```

Expected: homepage shows FruitLink, not electronics-shop content.

- [ ] **Step 2: Desktop check**

At around 1440px width, verify:

- Two-column hero layout.
- Marketplace package grid has at least 3 cards per row.
- Dashboard cards align cleanly.
- CTA buttons are visible.
- Hero headline is visible without scrolling past the hero section.

- [ ] **Step 3: Tablet check**

At around 768px width, verify:

- Hero content stacks or remains readable without text overlap.
- Marketplace uses 2-column cards.
- No text truncation in package cards.
- No horizontal overflow.

- [ ] **Step 4: Mobile check**

At around 375px width, verify:

- Cards stack vertically.
- Navigation wraps without breaking layout.
- Buttons are at least 44px tall.
- Body text remains at least 14px.
- No horizontal overflow. In browser console, this should be true: `document.body.scrollWidth <= window.innerWidth`.

- [ ] **Step 5: Fix visual issues**

If issues appear, adjust only `fruitlink.css` or small markup classes in `fruitlink-render.php`.

- [ ] **Step 6: Re-run syntax checks after fixes**

Run:

```bash
docker compose exec -T wordpress php -l /var/www/html/wp-content/themes/web-khoi-nghiep/functions.php
docker compose exec -T wordpress php -l /var/www/html/wp-content/themes/web-khoi-nghiep/inc/fruitlink-data.php
docker compose exec -T wordpress php -l /var/www/html/wp-content/themes/web-khoi-nghiep/inc/fruitlink-render.php
```

Expected: all three report `No syntax errors detected`.

## Task 7: Final quality review

**Files:**
- No source changes expected unless review finds issues.

- [ ] **Step 1: Inspect git diff**

Run:

```bash
git diff -- src/nongsanviet/wp-content/themes/web-khoi-nghiep docs/superpowers fruitlink-analysis.md docker-compose.yml
```

Expected: changes are limited to FruitLink UI files, the approved spec/plan, and earlier Docker Compose conflict fix if still unstaged.

- [ ] **Step 2: Run final command verification**

Run:

```bash
curl -fsSL http://localhost:8080 | grep -E "FruitLink|Kết nối đầu tư nông sản|Cam Cao Phong|Nhật ký canh tác"
```

Expected: all key strings are present.

- [ ] **Step 3: Request code review**

Use `code-reviewer` agent with this context:

```text
Review the FruitLink WordPress UI prototype changes. Focus on PHP safety, WordPress child-theme boundaries, escaping, scoped CSS, and whether the implementation matches docs/superpowers/specs/2026-05-19-fruitlink-uiux-design.md. Do not modify files.
```

- [ ] **Step 4: Address CRITICAL/HIGH review issues**

If code review reports CRITICAL or HIGH issues, fix them and repeat Task 5 through Task 7 Step 3.

- [ ] **Step 5: Final report**

Report:

- Files changed.
- Verification commands run.
- Browser checks performed.
- Any known limitations.

Do not claim completion until command verification and browser checks have been performed.
