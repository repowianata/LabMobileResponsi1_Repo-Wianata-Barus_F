import 'package:flutter/material.dart';
import '../bloc/produk_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/produk.dart';
import 'produk_page.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _food_itemTextboxController = TextEditingController();
  final _caloriesTextboxController = TextEditingController();
  final _fat_contentTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _food_itemTextboxController.text = widget.produk?.food_item ?? '';
        _caloriesTextboxController.text = widget.produk?.calories?.toString() ?? '';
        _fat_contentTextboxController.text = widget.produk?.fat_content?.toString() ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(fontFamily: 'SansSerif'),
        ),
        backgroundColor: Colors.green, // Warna hijau untuk AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _food_itemTextField(),
                _caloriesTextField(),
                _fat_contentTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _food_itemTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Food Item",
        labelStyle: TextStyle(
          fontFamily: 'SansSerif',
          color: Colors.green, // Warna label hijau
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green), // Garis hijau saat fokus
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _food_itemTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Nama produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _caloriesTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Jumlah kalori",
        labelStyle: TextStyle(
          fontFamily: 'SansSerif',
          color: Colors.green,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _caloriesTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Jumlah kalori harus diisi";
        } else if (int.tryParse(value) == null) {
          return "Masukkan angka yang valid";
        }
        return null;
      },
    );
  }

  Widget _fat_contentTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Jumlah lemak (g)",
        labelStyle: TextStyle(
          fontFamily: 'SansSerif',
          color: Colors.green,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _fat_contentTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Jumlah lemak harus diisi";
        } else if (int.tryParse(value) == null) {
          return "Masukkan angka yang valid";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.yellow, // Warna latar belakang tombol kuning
        side: const BorderSide(color: Colors.green), // Garis hijau
      ),
      child: Text(
        tombolSubmit,
        style: const TextStyle(
          fontFamily: 'SansSerif',
          color: Colors.green, // Warna teks hijau
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (!_isLoading) {
            if (widget.produk != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });

    Produk createProduk = Produk(id: null);
    createProduk.food_item = _food_itemTextboxController.text;
    createProduk.calories = int.parse(_caloriesTextboxController.text);
    createProduk.fat_content = int.parse(_fat_contentTextboxController.text);

    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.food_item = _food_itemTextboxController.text;
    updateProduk.calories = int.parse(_caloriesTextboxController.text);
    updateProduk.fat_content = int.parse(_fat_contentTextboxController.text);

    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
