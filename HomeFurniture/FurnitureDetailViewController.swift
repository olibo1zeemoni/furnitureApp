
import UIKit

class FurnitureDetailViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var furniture: Furniture?
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    init?(coder: NSCoder, furniture: Furniture?) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "\(String(describing: furniture!.name))"
        
        updateView()
    }
    
    func updateView() {
        let data = UIImage(named: "hat03")!.jpegData(compressionQuality: 0.9)
        guard let furniture = furniture else {return}
        let imageData = furniture.imageData ?? data
        
        let image = UIImage(data: imageData!) //UIImage(named: "hat03")//{
        photoImageView.image = image
       // } else {
           // photoImageView.image =  UIImage(named: "hat03")
       // }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Select Image Path", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            imagePicker.sourceType = .camera
        }))/*;
            
        alertController.addAction(UIAlertAction(title: "Photos", style: .default, handler: { _ in
                imagePicker.sourceType = .photoLibrary
            
        }))*/
            
        } else {
        let photoLibraryAction = UIAlertAction(title: "Photos", style: .default, handler: { _ in
            imagePicker.sourceType = .photoLibrary
            NSLog("Photos Selected")
        })
            alertController.addAction(photoLibraryAction)
            
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        photoImageView.image = selectedImage
                        
        let result = selectedImage.jpegData(compressionQuality: 0.9)
        if let furniture = furniture {
            furniture.imageData = result
            updateView()
        }
        //furniture?.imageData = result
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        guard let furniture = furniture else {
            return
        }
        let image = photoImageView.image
        let description = furniture.description
        let activityController = UIActivityViewController(activityItems: [image!, description], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIButton
        activityController.isModalInPresentation = true
        self.present(activityController, animated: true, completion: nil)
    }
    
}
