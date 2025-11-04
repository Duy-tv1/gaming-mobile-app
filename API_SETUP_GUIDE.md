# 🔑 RAWG API Key Setup Guide

## ⚠️ IMPORTANT: API Key Required

The RAWG API now requires an API key. Follow these simple steps to get your **FREE** API key:

## 📝 Step-by-Step Instructions

### Step 1: Go to RAWG API Documentation
Visit: **https://rawg.io/apidocs**

### Step 2: Click "Get API Key"
- Look for the button that says "Get API Key" or "Sign Up"
- It's usually at the top of the page

### Step 3: Sign Up for Free
You can sign up using:
- Email address
- Google account
- GitHub account
- Or other social login options

### Step 4: Get Your API Key
- After signing up, you'll be taken to your dashboard
- Your API key will be displayed
- Copy it (it looks something like: `a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6`)

### Step 5: Add API Key to Your App
1. Open the file: `lib/services/game_api_service.dart`
2. Find this line:
   ```dart
   static const String apiKey = 'YOUR_API_KEY_HERE';
   ```
3. Replace `YOUR_API_KEY_HERE` with your actual API key:
   ```dart
   static const String apiKey = 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6';
   ```

### Step 6: Save and Run
1. Save the file
2. Run the app: `flutter run`
3. The app will now fetch games successfully! 🎉

## 🚀 Quick Example

**Before:**
```dart
static const String apiKey = 'YOUR_API_KEY_HERE';
```

**After:**
```dart
static const String apiKey = 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6';
```

## ✅ Verification

To verify your API key is working:

1. Run the app
2. You should see games loading
3. If you see an error "The key parameter is not provided", the API key is not set correctly

## 🆓 Free Tier Limits

RAWG API Free Tier includes:
- ✅ 20,000 requests per month
- ✅ Access to all game data
- ✅ No credit card required
- ✅ Perfect for this project!

## 🔒 Security Note

**Important:** In production apps, you should NOT hardcode API keys in your source code. Instead:
- Use environment variables
- Use Flutter's `--dart-define` flag
- Store in secure configuration files
- Use backend proxy

For this educational project, hardcoding is acceptable.

## ❓ Troubleshooting

### Issue: "The key parameter is not provided"
**Solution:** 
- Make sure you replaced `YOUR_API_KEY_HERE` with your actual API key
- Make sure the API key is wrapped in quotes: `'your-key-here'`
- Make sure there are no extra spaces

### Issue: "Invalid API key"
**Solution:**
- Double-check you copied the entire API key
- Make sure you're logged into RAWG
- Try generating a new API key

### Issue: "Rate limit exceeded"
**Solution:**
- Free tier allows 20,000 requests/month
- Wait for the rate limit to reset (usually next month)
- Or create a new account

## 🎯 File Location

The file you need to edit is located at:
```
lib/services/game_api_service.dart
```

Look for line 13:
```dart
static const String apiKey = 'YOUR_API_KEY_HERE'; // ⚠️ REPLACE THIS
```

## 📸 Visual Guide

1. **Go to**: https://rawg.io/apidocs
   ```
   [Get API Key Button]
   ```

2. **Sign Up**: Use email or social login
   ```
   [Sign Up Form]
   ```

3. **Copy Key**: From your dashboard
   ```
   Your API Key: a1b2c3d4e5f6g7h8i9j0
   [Copy Button]
   ```

4. **Paste in Code**: In game_api_service.dart
   ```dart
   static const String apiKey = 'a1b2c3d4e5f6g7h8i9j0';
   ```

## 🎉 You're All Set!

Once you've added your API key, the app will:
- ✅ Fetch games from RAWG API
- ✅ Display game images and details
- ✅ Cache data for offline use
- ✅ Work perfectly with all features

---

**Need Help?** 
- RAWG API Docs: https://rawg.io/apidocs
- Support: Contact RAWG support or check their FAQ

**Student**: Tran Van Duy - SE183134
**Project**: Gaming Library App
