# Rak Buku – Aplikasi Manajemen Buku Pribadi

**Nama:** Settiani Simanjuntak  
**NIM:** 124140055  
**Kelas Praktikum:** RA  
**Mata kuliah:** Pengembangan Aplikasi Web – Pertemuan 3 (React Basics)

## Deskripsi Aplikasi

Rak Buku adalah aplikasi web untuk mencatat buku pribadi. Setiap buku punya tiga status:

| Status | Arti |
|---|---|
| **Milik** | buku yang sudah dimiliki |
| **Sedang dibaca** | buku yang sedang dibaca |
| **Ingin dibeli** | buku yang ingin dibeli |

Fitur utama:

- Menambah buku (judul, penulis, status)
- Mengedit dan menghapus buku (hapus meminta konfirmasi)
- Filter buku berdasarkan status
- Pencarian berdasarkan judul atau nama penulis
- Halaman statistik koleksi (total, jumlah per status, penulis terbanyak)
- Data tersimpan permanen di `localStorage`, jadi tidak hilang saat halaman di-refresh
- Validasi form: kolom wajib diisi dengan pesan error merah dan border merah pada input

## Instalasi dan Menjalankan

Prasyarat: Node.js 18 atau lebih baru.

```bash
# Cara cepat di Windows: klik dua kali jalankan.bat

# 1. Masuk ke folder project
cd settianisimanjuntak_124140055_pertemuan3

# 2. Pasang dependensi
npm install

# 3. Jalankan mode pengembangan
npm run dev        # buka alamat yang tampil, biasanya http://localhost:5173

# 4. Jalankan unit test
npm test

# 5. (opsional) build produksi
npm run build
```

## Struktur Folder

```
src/
├── components/
│   ├── BookForm/     BookForm.jsx, BookForm.css, BookForm.test.jsx
│   ├── BookList/     BookList.jsx, BookList.css, BookList.test.jsx
│   ├── BookItem/     BookItem.jsx, BookItem.css
│   ├── BookFilter/   BookFilter.jsx, BookFilter.css, BookFilter.test.jsx
│   └── Navbar/       Navbar.jsx, Navbar.css
├── pages/
│   ├── Home/         Home.jsx, Home.css
│   ├── Stats/        Stats.jsx, Stats.css
│   └── NotFound/     NotFound.jsx
├── hooks/
│   ├── useLocalStorage.js (+ test)
│   └── useBookStats.js    (+ test)
├── context/BookContext.jsx
├── constants/status.js
├── App.jsx, App.test.jsx, main.jsx, index.css, setupTests.js
```

## Screenshot Antarmuka

| Halaman Koleksi | Validasi Error | Halaman Statistik |
|---|---|---|
| ![Koleksi](docs/screenshots/koleksi.png) | ![Validasi](docs/screenshots/validasi.png) | ![Statistik](docs/screenshots/statistik.png) |

## Penjelasan Fitur React yang Digunakan

| Konsep | Lokasi | Penjelasan |
|---|---|---|
| **Functional components + Hooks** | semua file di `components/` dan `pages/` | Semua komponen berupa fungsi, tanpa class. |
| **useState** | `BookForm`, `BookItem`, `Home`, `BookContext` | Menyimpan isi form, error, status konfirmasi hapus, buku yang diedit, filter, dan kata kunci pencarian. |
| **useEffect** | `BookForm`, `useLocalStorage` | `BookForm` mengisi ulang form saat buku yang diedit berganti. `useLocalStorage` menyimpan data ke localStorage setiap data berubah. |
| **useMemo / useCallback** | `BookContext`, `useBookStats` | Daftar hasil filter, nilai context, dan statistik hanya dihitung ulang saat inputnya berubah. |
| **Komponen reusable (5)** | `BookForm`, `BookList`, `BookItem`, `BookFilter`, `Navbar` | `BookForm` dipakai untuk tambah dan edit. `BookItem` dipakai ulang oleh `BookList`. |
| **Context API** | `context/BookContext.jsx` | `BookProvider` menyediakan `books`, `filteredBooks`, filter, pencarian, dan fungsi `addBook`, `updateBook`, `deleteBook`. Komponen mengaksesnya lewat hook `useBooks()`. |
| **React Router** | `main.jsx`, `App.jsx`, `Navbar.jsx` | Rute `/` (Koleksi), `/stats` (Statistik), dan `*` (404). `NavLink` menandai halaman aktif. |
| **Custom hook (2)** | `hooks/` | `useLocalStorage` (state yang tersinkron ke localStorage) dan `useBookStats` (hitung statistik). |
| **PropTypes** | semua komponen | Setiap komponen mendeklarasikan tipe props, termasuk `shape` untuk objek buku dan `oneOf` untuk status. |
| **Controlled components** | `BookForm`, `BookFilter` | Nilai input dikendalikan state React. |
| **Conditional rendering** | `BookList`, `BookItem`, `Stats`, `BookForm` | Pesan kosong, mode edit vs tambah, konfirmasi hapus, dan pesan error. |
| **Rendering list + key** | `BookList`, `Stats` | `map()` dengan `key` unik (`book.id`). |
| **Error handling form** | `BookForm.jsx` | `validateBook()` memeriksa judul dan penulis tidak kosong (spasi saja ditolak). Error ditampilkan di bawah input dengan `role="alert"`, input diberi `aria-invalid` dan border merah. Data tidak valid tidak dikirim. |

## Pengujian (Vitest + React Testing Library)

Total **28 test** dalam 6 file, semuanya lulus.

| File test | Jumlah | Yang diuji |
|---|---|---|
| `BookForm.test.jsx` | 6 | render field, error kolom kosong, input spasi, submit valid dan reset, mode edit, fungsi validasi |
| `BookFilter.test.jsx` | 3 | input pencarian, klik filter status, `aria-pressed` |
| `BookList.test.jsx` | 4 | pesan kosong, render daftar, tombol edit, konfirmasi hapus |
| `useLocalStorage.test.js` | 4 | nilai awal, baca data, simpan data, JSON rusak |
| `useBookStats.test.js` | 3 | total dan persentase, penulis terbanyak, data kosong |
| `App.test.jsx` | 8 | tambah, persisten localStorage, filter, pencarian, edit, hapus, navigasi, 404 |

Hasil lengkap eksekusi ada di [`docs/hasil-test.txt`](docs/hasil-test.txt).

![Hasil test](docs/screenshots/test.png)
