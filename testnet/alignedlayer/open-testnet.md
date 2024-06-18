---
layout:
  title:
    visible: true
  description:
    visible: false
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Open Testnet

Docs : [https://mirror.xyz/0x7794D1c55568270A81D8Bf39e1bcE96BEaC10901/F99hEjkxcsWNefjnaEhoxCOPgHn0I7oJG3fflRjQUGU](https://mirror.xyz/0x7794D1c55568270A81D8Bf39e1bcE96BEaC10901/F99hEjkxcsWNefjnaEhoxCOPgHn0I7oJG3fflRjQUGU)

Saya hanya memperjelas tutorial disini&#x20;

_**kalian bisa pakai codespace**_

### Buat folder aligned

```bash
mkdir aligned
```

Download dan install aligned

```bash
curl -L https://raw.githubusercontent.com/yetanotherco/aligned_layer/main/batcher/aligned/install_aligned.sh | bash
```

Verify instalation

```bash
source /root/.bashrc
```

Download example SP1 proof file

```bash
curl -L https://raw.githubusercontent.com/yetanotherco/aligned_layer/main/batcher/aligned/get_proof_test_files.sh | bash
```

Send proof (disini tunggu beberapa menit sampe selesai)

```bash
/root/.aligned/bin/aligned submit --proving_system SP1 --proof ~/.aligned/test_files/sp1_fibonacci.proof --vm_program ~/.aligned/test_files/sp1_fibonacci-elf --aligned_verification_data_path ~/aligned_verification_data --conn wss://batcher.alignedlayer.com
```

_**outputnya seperti ini :**_&#x20;

<figure><img src="../../.gitbook/assets/image (15).png" alt=""><figcaption></figcaption></figure>

Verify proof

```bash
aligned verify-proof-onchain --aligned-verification-data ~/aligned_verification_data/*.json --rpc https://ethereum-holesky-rpc.publicnode.com --chain holesky
```

_**outputnya seperti ini :**_

<figure><img src="../../.gitbook/assets/image (14).png" alt=""><figcaption><p>verify proof</p></figcaption></figure>

### **Show proof of alignment:** Tweet link batch verifikasi mu dengan hashtag #aligned ✅ <a href="#heading-show-proof-of-alignment-tweet-the-link-to-your-batch-verification-with-aligned" id="heading-show-proof-of-alignment-tweet-the-link-to-your-batch-verification-with-aligned"></a>

<figure><img src="../../.gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>

#### Jangan lupa tag [@alignedlayer](https://x.com/alignedlayer) <a href="#heading-dont-forget-to-tag-alignedlayer" id="heading-dont-forget-to-tag-alignedlayer"></a>

Congratulations. You are now aligned. ✅
