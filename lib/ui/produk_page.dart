import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/produk_bloc.dart';
import '/model/produk.dart';
import '/ui/produk_detail.dart';
import '/ui/produk_form.dart';
import 'login_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Produk Kesehatan',
          style: TextStyle(fontFamily: 'SansSerif'),
        ),
        backgroundColor: Colors.green, // Warna hijau untuk tema kesehatan
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.yellow), // Ikon dengan warna kuning
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProdukForm()));
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'SansSerif',
                  color: Colors.green, // Warna hijau untuk teks drawer
                ),
              ),
              trailing: const Icon(Icons.logout, color: Colors.green),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                  );
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Produk>>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListProduk(list: snapshot.data);
          } else {
            return const Center(child: Text('No products found.'));
          }
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List<Produk>? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemProduk(produk: list![i]);
      },
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Card(
        color: Colors.green[50], // Warna latar belakang kartu
        shadowColor: Colors.green, // Warna bayangan kartu
        child: ListTile(
          title: Text(
            produk.food_item ?? 'Unknown Food Item', // Menambahkan fallback jika food_item null
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontWeight: FontWeight.bold,
              color: Colors.green, // Warna teks hijau
            ),
          ),
          subtitle: Text(
            '${produk.calories} Calories',
            style: const TextStyle(
              fontFamily: 'SansSerif',
              color: Colors.black87, // Warna teks subtitle
            ),
          ),
          trailing: Text(
            '${produk.fat_content} Fat',
            style: const TextStyle(
              fontFamily: 'SansSerif',
              color: Colors.yellow, // Warna kuning untuk konten fat
            ),
          ),
        ),
      ),
    );
  }
}
