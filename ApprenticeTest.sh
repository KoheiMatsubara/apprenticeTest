#!/bin/bash

password_file="passwords.txt"

mkdir -p ~/.password_manager

touch ~/.password_manager/$password_file

save_password() {
    read -p "サービス名を入力してください：" service
    read -p "ユーザー名を入力してください：" username
    read -s -p "パスワードを入力してください：" password
    
    echo "$service:$username:$password" >> ~/.password_manager/$password_file
    echo "パスワードの追加は成功しました。"
}

get_password() {
    read -p "サービス名を入力してください：" service
    password=$(grep "^$service:" ~/.password_manager/$password_file | cut -d ':' -f 2,3)
    if [ -n "$password" ]; then
        echo "サービス名：$service"
        echo "ユーザー名/パスワード：$password"
    else
        echo "そのサービスは登録されていません。"
    fi
}

main_menu() {
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read choice
    case $choice in
        "Add Password") save_password ;;
        "Get Password") get_password ;;
        "Exit") echo "Thank you!"; exit ;;
        *) echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。" ;;
    esac
}

while true; do
    main_menu
done
