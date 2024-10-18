import 'package:flutter/material.dart';
import '../bloc/produk_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/produk.dart';
import '/ui/produk_form.dart';
import 'produk_page.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(fontFamily: 'SansSerif'),
        ),
        backgroundColor: Colors.green, // Warna hijau untuk AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Text(
              "Food Item : ${widget.produk!.food_item}",
              style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'SansSerif',
                color: Colors.green, // Warna teks hijau
              ),
            ),
            const SizedBox(height: 10), // Memberi jarak antara teks
            Text(
              "Calories : ${widget.produk!.calories}",
              style: const TextStyle(
                fontSize: 18.0,
                fontFamily: 'SansSerif',
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Fat Content : ${widget.produk!.fat_content}g",
              style: const TextStyle(
                fontSize: 18.0,
                fontFamily: 'SansSerif',
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green), // Garis luar hijau
            backgroundColor: Colors.yellow, // Latar belakang tombol kuning
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(
              fontFamily: 'SansSerif',
              color: Colors.green, // Teks hijau
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Memberi jarak antara tombol
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green),
            backgroundColor: Colors.yellow,
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(
              fontFamily: 'SansSerif',
              color: Colors.green,
            ),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(
          fontFamily: 'SansSerif',
          color: Colors.green, // Teks hijau
        ),
      ),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green),
          ),
          child: const Text(
            "Ya",
            style: TextStyle(
              fontFamily: 'SansSerif',
              color: Colors.green,
            ),
          ),
          onPressed: () {
            ProdukBloc.deleteProduk(id: widget.produk!.id!).then((value) => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProdukPage()),
              )
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ));
            });
          },
        ),
        // Tombol Batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green),
          ),
          child: const Text(
            "Batal",
            style: TextStyle(
              fontFamily: 'SansSerif',
              color: Colors.green,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
