# 📤 Hướng dẫn Push Project lên GitHub

## Bước 1: Tạo Repository trên GitHub

1. Đăng nhập vào GitHub: https://github.com
2. Click nút **"New"** hoặc **"+"** → **"New repository"**
3. Điền thông tin:
   - **Repository name**: `tranvanduy_se183134`
   - **Description**: `Gaming Library App - Flutter Mobile Application`
   - **Visibility**: Public hoặc Private
   - **KHÔNG** check "Add a README file" (vì đã có sẵn)
4. Click **"Create repository"**

---

## Bước 2: Chuẩn bị Project

### 2.1. Thêm file .gitignore (nếu chưa có)

File `.gitignore` đã có sẵn, kiểm tra nội dung:

```bash
# Xem nội dung .gitignore
type .gitignore
```

### 2.2. Thêm video demo vào folder video

```bash
# Tạo folder video (đã tạo sẵn)
# Copy file video demo vào:
# D:\FA25\PRM392\project\pe_project\video\demo.mp4

# Hoặc dùng PowerShell:
Copy-Item "đường_dẫn_video_của_bạn\demo.mp4" "video\demo.mp4"
```

**LƯU Ý:** 
- Nếu video > 100MB, nên upload lên YouTube/Google Drive
- Sau đó thêm link vào README.md

---

## Bước 3: Khởi tạo Git và Push

### 3.1. Mở Terminal/PowerShell trong VS Code
**Phím tắt:** `Ctrl + ~` hoặc View → Terminal

### 3.2. Chạy các lệnh sau:

```bash
# Di chuyển đến thư mục project
cd D:\FA25\PRM392\project\pe_project

# Khởi tạo Git repository (nếu chưa có)
git init

# Thêm tất cả files vào staging
git add .

# Commit với message
git commit -m "Initial commit: Gaming Library App - Tran Van Duy SE183134"

# Thêm remote repository (thay YOUR_USERNAME bằng username GitHub của bạn)
git remote add origin https://github.com/YOUR_USERNAME/tranvanduy_se183134.git

# Push code lên GitHub
git push -u origin main
```

**Nếu branch là master thay vì main:**
```bash
git branch -M main
git push -u origin main
```

---

## Bước 4: Upload Video (nếu file lớn)

### Cách 1: Git LFS (Large File Storage) - Cho file > 100MB

```bash
# Cài đặt Git LFS
git lfs install

# Track file video
git lfs track "*.mp4"

# Commit file .gitattributes
git add .gitattributes
git commit -m "Add Git LFS tracking for videos"

# Add và push video
git add video/demo.mp4
git commit -m "Add demo video"
git push
```

### Cách 2: Upload lên YouTube/Google Drive (Khuyến khích)

1. Upload video lên YouTube hoặc Google Drive
2. Lấy link public
3. Cập nhật README.md:

```markdown
## 📱 Demo Video

**Watch Demo:** [Click here to watch](https://youtu.be/YOUR_VIDEO_ID)

<!-- Hoặc Google Drive -->
**Download Demo:** [Google Drive Link](https://drive.google.com/file/d/YOUR_FILE_ID)
```

---

## Bước 5: Xác nhận đã Push thành công

### Kiểm tra trên GitHub:
1. Mở trình duyệt
2. Vào: `https://github.com/YOUR_USERNAME/tranvanduy_se183134`
3. Xem các file đã được push

### Kiểm tra local:
```bash
# Xem status
git status

# Xem remote
git remote -v

# Xem log
git log --oneline
```

---

## Bước 6: Cập nhật README với link GitHub

Trong file README.md, thêm link repository:

```markdown
## 🔗 Links

- **GitHub Repository:** https://github.com/YOUR_USERNAME/tranvanduy_se183134
- **Demo Video:** [Watch on YouTube](YOUR_YOUTUBE_LINK)
```

Sau đó commit và push lại:
```bash
git add README.md
git commit -m "Update README with GitHub link"
git push
```

---

## 📋 Commands Cheat Sheet

```bash
# Khởi tạo Git
git init

# Thêm files
git add .                          # Thêm tất cả
git add filename                   # Thêm file cụ thể

# Commit
git commit -m "message"

# Xem status
git status

# Xem history
git log

# Thêm remote
git remote add origin URL

# Push
git push -u origin main            # Lần đầu
git push                          # Lần sau

# Pull (lấy code mới từ GitHub)
git pull

# Clone repository
git clone URL
```

---

## ⚠️ Lỗi thường gặp và cách fix

### Lỗi 1: "Permission denied"
```bash
# Cần xác thực GitHub
# Cách 1: Dùng Personal Access Token
# Tạo token tại: https://github.com/settings/tokens

# Cách 2: Dùng GitHub CLI
winget install --id GitHub.cli
gh auth login
```

### Lỗi 2: "Repository not found"
```bash
# Kiểm tra lại URL
git remote -v

# Sửa URL nếu sai
git remote set-url origin https://github.com/USERNAME/REPO.git
```

### Lỗi 3: "Large file detected"
```bash
# File > 100MB cần dùng Git LFS
git lfs install
git lfs track "*.mp4"
git add .gitattributes
```

### Lỗi 4: "Refused to merge unrelated histories"
```bash
git pull origin main --allow-unrelated-histories
```

---

## 📁 Cấu trúc đã Push lên GitHub

```
tranvanduy_se183134/
├── .gitignore
├── README.md                      ✅ Đã cập nhật
├── pubspec.yaml                   ✅ Đã đổi tên
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── database/
│   ├── services/
│   ├── providers/
│   └── screens/
├── android/                       ✅ Đã cập nhật package name
├── video/
│   └── demo.mp4                   📹 Thêm video của bạn
└── Các file tài liệu

KHÔNG push:
❌ /build/
❌ /.dart_tool/
❌ /android/app/build/
```

---

## ✅ Checklist trước khi Push

- [ ] Đã tạo repository trên GitHub
- [ ] File .gitignore có đầy đủ
- [ ] Đã test app chạy OK
- [ ] README.md đã cập nhật đầy đủ
- [ ] Video demo đã thêm (hoặc có link)
- [ ] Không có file build/cache trong git
- [ ] API key đã được set đúng
- [ ] Đã commit với message rõ ràng

---

## 🎯 Next Steps sau khi Push

1. **Tạo Releases:**
   - Đi đến tab "Releases" trên GitHub
   - Click "Create a new release"
   - Tag version: `v1.0.0`
   - Upload file APK đã build

2. **Cập nhật README badges:**
   ```markdown
   ![Flutter](https://img.shields.io/badge/Flutter-v3.9.2-blue)
   ![Dart](https://img.shields.io/badge/Dart-3.0-blue)
   ![License](https://img.shields.io/badge/License-Educational-green)
   ```

3. **Thêm Screenshots:**
   - Tạo folder `screenshots`
   - Chụp màn hình app
   - Thêm vào README

---

## 👨‍💻 Tác giả

**Tran Van Duy - SE183134**
- GitHub: https://github.com/YOUR_USERNAME
- Project: tranvanduy_se183134

---

**🎉 Chúc bạn push thành công!**
