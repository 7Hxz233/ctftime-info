require 'json'

file = open("db.json")
json = JSON.load(file)

# how many task we've collected
def record_count
  json.count
end

tags = {crypto:    %w{crypto cryptograhy cryptanalysis cryptoanalysis base32 brute bruteforce caesar cbc enigma hash md5 openssl salt sha1 vernam},
        reverse:   %w{reverse reversing re re1 re5 bin binary 64bit amd64 arm assembly cpu crack},
        pwn:       %w{pwn bin 64bit amd64 arm assembly buffer-overflow code-injection exp exploit exploitation libc pwnable pwnables pwning rop shellcode strcmp},
        audit:     %w{audit stegno stegano steganography forsensics libpcap wireshark},
        web:       %w{web xss cookie django dns file net networking nosql sql sqlinjection webhacking websecurity},
        android:   %w{android apk dalvik},
        algorithm: %w{algo algorithm acm code coding},
        baby:      %w{baby babys babyfirst}}


