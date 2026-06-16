from bing_image_downloader import downloader

food_classes = ["Nasi Goreng", "Ayam Geprek", "Mie Ayam", "Bakso", "Soto"]

for food in food_classes:
    print(f"Mengunduh dataset untuk: {food}")
    downloader.download(
        food, 
        limit=30, 
        output_dir='dataset_nutrilocal', 
        adult_filter_off=True, 
        force_replace=False, 
        timeout=60, 
        verbose=True
    )